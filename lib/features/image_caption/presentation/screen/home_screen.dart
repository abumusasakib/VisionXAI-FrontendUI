import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/controls_widget.dart';
import 'package:vision_xai/features/image_caption/presentation/screen/widget/image_display.dart';

import 'package:vision_xai/l10n/localization_extension.dart';
import 'package:vision_xai/core/services/notification_service.dart';
import 'package:vision_xai/core/services/dialog_service.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_xai/core/routes/app_routes.dart';
import 'package:vision_xai/features/settings/presentation/cubit/settings_feature_cubit.dart';
import 'package:vision_xai/features/settings/domain/entity/settings_entity.dart';

import '../cubit/home/home_cubit.dart';
import '../cubit/home/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr.appTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to the settings page using GoRouter
              context.push(AppRoutes.settings);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SettingsFeatureCubit, SettingsEntity?>(
            listener: (context, state) {
              if (state != null) {
                log('Settings changed: locale=${state.locale} ip=${state.ip}');
              }
            },
          ),
          BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                // Show error dialog
                log('Error: ${state.errorMessage}');
                DialogService.showAlert(
                  context: context,
                  title: context.tr.errorTitle,
                  content: state.errorMessage!,
                  okLabel: context.tr.ok,
                  onOk: () => context.read<HomeCubit>().reset(),
                );
              }
            },
          ),
          BlocListener<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                current.infoMessage != null &&
                current.infoMessage != previous.infoMessage,
            listener: (context, state) {
              if (state.infoMessage != null) {
                final ns = context.read<NotificationService>();
                final msg = state.infoMessage!;
                if (context.mounted) {
                  try {
                    ns.showSnackBar(msg,
                        duration: const Duration(milliseconds: 2500));
                  } catch (_) {}
                }
                context.read<HomeCubit>().clearInfoMessage();
              }
            },
          ),
        ],
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              // Handle errors
              log('Error: ${state.errorMessage}');
            }
          },
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            final picker = ImagePicker();

            return LayoutBuilder(
              builder: (context, constraints) {
                final isWideScreen = constraints.maxWidth > 600;

                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: isWideScreen
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: imageDisplay(context, state),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 2,
                                  child: controlsWidget(
                                      context, cubit, state, picker),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                imageDisplay(context, state),
                                const SizedBox(height: 16),
                                controlsWidget(context, cubit, state, picker),
                              ],
                            ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
