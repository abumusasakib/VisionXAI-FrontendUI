import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vision_xai/features/settings/color_palette/presentation/cubit/palette/palette_cubit.dart';
import 'package:vision_xai/core/di/app_di.dart';
import 'package:vision_xai/core/di/service_locator.dart';
import 'package:vision_xai/l10n/app_localizations.dart';
import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/core/routes/routes.dart';
import 'package:vision_xai/core/services/global_ui_service.dart';
import 'package:vision_xai/core/services/progress_service.dart';
import 'package:provider/provider.dart';
import 'package:arb_utils/state_managers/l10n_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open a box for settings
  await Hive.openBox('settings');

  // Open a box for palette overrides
  await Hive.openBox('palette');

  // Ensure locale is set to 'bn' on first launch if not set yet
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('locale')) {
    await prefs.setString('locale', 'bn');
  }

  // Create DI after Hive is opened
  setupServiceLocator();
  final appDi = AppDi.create();
  // Load persisted settings into the SettingsFeatureCubit so UI shows them immediately
  await appDi.settingsFeatureCubit.load();
  // Load about info (app version, platform) so About screen can render immediately
  await appDi.aboutCubit.loadAppInfo();

  runApp(MyApp(appDi: appDi));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.appDi});
  final AppDi appDi;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppDi get appDi => widget.appDi;

  @override
  void dispose() {
    // Dispose DI container to close long-lived resources.
    // This intentionally doesn't await the future because dispose can't be async.
    appDi.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Trigger an initial palette load after the first frame so the
    // application's navigator and localization delegates are available.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Only run once
      try {
        // Show a brief blocking progress dialog while the palette is loaded.
        await ProgressService.show(null, message: 'Generating Palette...');
        try {
          await widget.appDi.paletteCubit.updateColors();
        } finally {
          ProgressService.hide();
        }
      } catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use app-level DI (constructed in main) to provide single-instance cubits
    final imageCaptionCubit = appDi.imageCaptionCubit;
    final homeCubit = appDi.homeCubit;

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => imageCaptionCubit),
        BlocProvider(create: (context) => homeCubit),
        BlocProvider.value(value: appDi.settingsFeatureCubit),
        // PaletteCubit is provided from AppDi (resolved via service locator)
        BlocProvider.value(value: appDi.paletteCubit),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ProviderL10n(),
        child: Builder(
          builder: (context) {
            // Expose NotificationService to the widget tree for easy access
            // via Provider (context.read<NotificationService>()).
            return MultiProvider(
              providers: [
                Provider.value(value: appDi.notificationService),
              ],
                child: BlocBuilder<PaletteCubit, PaletteState>(
                builder: (context, paletteState) {
                  return MaterialApp.router(
                    scaffoldMessengerKey: GlobalUiService.scaffoldMessengerKey,
                    onGenerateTitle: (cxt) => cxt.tr.appTitle,
                    locale: context.watch<ProviderL10n>().locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      colorScheme: ColorScheme.light(
                        primary: paletteState.primaryColor,
                        secondary: paletteState.secondaryColor,
                        tertiary: paletteState.backgroundColor,
                      ),
                      scaffoldBackgroundColor: paletteState.backgroundColor,
                      appBarTheme: AppBarTheme(
                        backgroundColor: paletteState.primaryColor,
                        foregroundColor: Colors.white,
                        // Use the palette secondary color for action icons in
                        // the app bar so accents reflect user palette.
                        actionsIconTheme:
                            IconThemeData(color: paletteState.secondaryColor),
                      ),
                      tabBarTheme: TabBarTheme(
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                color: paletteState.secondaryColor,
                                width: 2.0)),
                        labelColor: paletteState.secondaryColor,
                      ),
                      buttonTheme: ButtonThemeData(
                        buttonColor: paletteState.secondaryColor,
                        textTheme: ButtonTextTheme.primary,
                      ),
                      // Ensure black text and icons on buttons
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.black),
                        ),
                      ),
                      elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.black),
                        ),
                      ),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all(Colors.black),
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.white,
                      ),
                      primaryIconTheme: const IconThemeData(
                        color: Colors.white,
                      ),
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: paletteState.secondaryColor,
                        foregroundColor: Colors.white,
                      ),
                      bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        selectedItemColor: paletteState.secondaryColor,
                        unselectedItemColor: Colors.grey,
                      ),
                    ),
                    routerConfig: createRouter(appDi),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

