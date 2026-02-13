import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// The title of the application.
  ///
  /// In en, this message translates to:
  /// **'VisionXAI'**
  String get appTitle;

  /// The title for the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsScreenTitle;

  /// The IP address of the server.
  ///
  /// In en, this message translates to:
  /// **'IP Address'**
  String get ip;

  /// The port of the server.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// Success message for IP and port update.
  ///
  /// In en, this message translates to:
  /// **'IP and Port updated successfully'**
  String get ipPortUpdated;

  /// Error message for IP and port not entered.
  ///
  /// In en, this message translates to:
  /// **'Please enter IP and Port'**
  String get enterIpAndPort;

  /// Text for the update IP button.
  ///
  /// In en, this message translates to:
  /// **'Update IP Address'**
  String get updateIp;

  /// Error message for image upload failure.
  ///
  /// In en, this message translates to:
  /// **'Image upload failed'**
  String get imageUploadFailedMessage;

  /// Text for the choose image button.
  ///
  /// In en, this message translates to:
  /// **'Choose image to generate caption'**
  String get chooseImage;

  /// Text when no image has been chosen.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// Text for the generating caption message.
  ///
  /// In en, this message translates to:
  /// **'Generating Caption...'**
  String get generatingCaption;

  /// Text for the caption text.
  ///
  /// In en, this message translates to:
  /// **'Caption will appear here'**
  String get captionText;

  /// Text for the stop text.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopCaptionGeneration;

  /// Text for the upload image button.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;

  /// Text for the generate caption button.
  ///
  /// In en, this message translates to:
  /// **'Generate Caption'**
  String get generateCaption;

  /// Text for the select image from text.
  ///
  /// In en, this message translates to:
  /// **'Select image from source'**
  String get selectImageFrom;

  /// Text to capture image from camera.
  ///
  /// In en, this message translates to:
  /// **'Capture Image with Camera'**
  String get camera;

  /// Text for the select image from gallery.
  ///
  /// In en, this message translates to:
  /// **'Select Image from Gallery'**
  String get selectImageFromGallery;

  /// Title for error messages.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// Text for the OK button.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// The language information for the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// The title for the language settings screen.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// Text for the select language text.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// The title for the IP configuration screen.
  ///
  /// In en, this message translates to:
  /// **'IP Configuration'**
  String get ipConfiguration;

  /// Error message for no language selected.
  ///
  /// In en, this message translates to:
  /// **'No Language Selected'**
  String get noLanguageSelected;

  /// The title for the about screen.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Text for the current language.
  ///
  /// In en, this message translates to:
  /// **'Current Language'**
  String get currentLanguage;

  /// Text for the version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Text for the platform.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get platform;

  /// Text for the listen button.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// Text for the stop button.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// Error message for image upload failure with status code.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload image. Status: {statusCode}'**
  String uploadFailed(Object statusCode);

  /// Message when image upload is cancelled.
  ///
  /// In en, this message translates to:
  /// **'Image upload was cancelled.'**
  String get uploadCancelled;

  /// Error message for image upload with error details.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during image upload: {error}'**
  String uploadError(Object error);

  /// Message when caption generation is cancelled.
  ///
  /// In en, this message translates to:
  /// **'Caption generation was cancelled.'**
  String get captionCancelled;

  /// Message when caption generation is stopped by the user.
  ///
  /// In en, this message translates to:
  /// **'Caption generation stopped by user.'**
  String get captionStopped;

  /// Error message for caption generation failure with status code.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate caption. Status: {statusCode}'**
  String captionFailed(Object statusCode);

  /// Message when caption generation is already in progress.
  ///
  /// In en, this message translates to:
  /// **'Caption generation already in progress.'**
  String get captionInProgress;

  /// General error message with error details.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String generalError(Object error);

  /// Message when there is no caption generation in progress.
  ///
  /// In en, this message translates to:
  /// **'No caption generation in progress.'**
  String get noCaptionInProgress;

  /// Short message indicating caption generation was stopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped caption generation...'**
  String get captionStoppedShort;

  /// Message indicating the image was uploaded successfully.
  ///
  /// In en, this message translates to:
  /// **'Image uploaded successfully.'**
  String get imageUploaded;

  /// Message indicating caption generation has been stopped.
  ///
  /// In en, this message translates to:
  /// **'Caption generation has been stopped.'**
  String get captionGenerationStopped;

  /// Error message when text-to-speech fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to speak the caption'**
  String get failedToSpeak;

  /// Error message when the connection times out.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again.'**
  String get connectionTimeout;

  /// Error message when the server returns a bad response.
  ///
  /// In en, this message translates to:
  /// **'Server error occurred (Status code: {statusCode}).'**
  String badResponse(Object statusCode);

  /// Message when the request is cancelled.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled.'**
  String get requestCancelled;

  /// Error message when there is no internet connection or the server is unreachable.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect. Please check your internet or server address.'**
  String get noInternetOrServerUnreachable;

  /// General error message for unexpected issues.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later.'**
  String get unknownError;

  /// Error message when the server does not provide a caption.
  ///
  /// In en, this message translates to:
  /// **'No caption available.'**
  String get captionMissing;

  /// Label for the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Palette Settings'**
  String get paletteSettings;

  /// Label for the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Color Configuration'**
  String get colorConfiguration;

  /// Label for the pick a color section.
  ///
  /// In en, this message translates to:
  /// **'Pick a Color'**
  String get pickAColor;

  /// Label for the primary color setting in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Primary Color'**
  String get primaryColor;

  /// Label for the secondary color setting in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Secondary Color'**
  String get secondaryColor;

  /// Label for the background color setting in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Background Color'**
  String get backgroundColor;

  /// Label for the actions section in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actionsSection;

  /// Label for the save action in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Label for the delete action in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Label for the clear action in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Label for the cancel action in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Title for the preset name alert dialog in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Name Preset'**
  String get presetNameAlertTitle;

  /// Placeholder text for the preset name input field in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Provide preset name'**
  String get presetNamePlaceholder;

  /// Label for selection actions (OK alternative).
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// Title for the presets list in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Presets List'**
  String get presetsList;

  /// Label for the save preset action in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Save Preset'**
  String get savePreset;

  /// Label for a generic generate action (used for short generate buttons).
  ///
  /// In en, this message translates to:
  /// **'Generate from Background'**
  String get generate;

  /// Label for the generate-from-image action.
  ///
  /// In en, this message translates to:
  /// **'Generate from Image'**
  String get generateFromImage;

  /// Label for choosing files from the device file system.
  ///
  /// In en, this message translates to:
  /// **'Pick from files'**
  String get pickFromFiles;

  /// Label for choosing an image from the gallery.
  ///
  /// In en, this message translates to:
  /// **'Pick from gallery'**
  String get pickFromGallery;

  /// Message shown when local files are not supported (web).
  ///
  /// In en, this message translates to:
  /// **'Local files not supported on web'**
  String get localFilesNotSupported;

  /// Error shown when palette generation fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate palette: {error}'**
  String paletteGenerationFailed(Object error);

  /// Text shown while the application generates a color palette from an image.
  ///
  /// In en, this message translates to:
  /// **'Generating Palette...'**
  String get generatingPalette;

  /// Label for the delete preset title in the palette settings section.
  ///
  /// In en, this message translates to:
  /// **'Delete Preset?'**
  String get deletePresetTitle;

  /// Message when the user is prompted to delete a preset.
  ///
  /// In en, this message translates to:
  /// **'Delete preset {presetName}?'**
  String deletePresetMessage(Object presetName);

  /// Message shown while palette overrides are being reset.
  ///
  /// In en, this message translates to:
  /// **'Resetting...'**
  String get resetting;

  /// Prompt shown to ask whether to reset palette overrides.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the color palette?'**
  String get resetPrompt;

  /// Message shown after palette overrides are reset successfully.
  ///
  /// In en, this message translates to:
  /// **'Reset successfully'**
  String get resetConfirmation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
