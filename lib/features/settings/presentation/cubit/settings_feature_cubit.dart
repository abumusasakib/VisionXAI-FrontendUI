import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:vision_xai/core/services/error_handle/error_handling.dart';

import '../../domain/entity/settings_entity.dart';
import '../../domain/use_case/settings_uc.dart';
import 'package:vision_xai/l10n/localization_extension.dart';

class SettingsFeatureCubit extends Cubit<SettingsEntity?> {
  final SettingsFeatureUC _useCase;

  SettingsFeatureCubit(this._useCase) : super(null);

  Future<void> load() async {
    final s = await _useCase.load();
    emit(s);
  }

  /// Variant of `load` that maps errors to localized messages using
  /// `mapErrorToMessage` and logs the mapped message. It preserves the
  /// original `load()` behavior but gives callers the option to provide a
  /// `BuildContext` to produce localized messages.
  Future<void> loadWithContext(BuildContext context) async {
    // Use runWithErrorHandling to centralize error mapping and optional
    // SnackBar display. We rethrow on error so callers observe the
    // original exception as before.
    final tr = context.tr;
    try {
      await runWithErrorHandling(() => load(),
          localizations: tr, rethrowOnError: true);
    } catch (e, st) {
      // Preserve localized logging for diagnostics.
      final message = mapErrorToMessage(e, tr);
      developer.log('Settings load failed: $message',
          name: 'SettingsFeatureCubit', error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<void> save(SettingsEntity entity) async {
    await _useCase.save(entity);
    emit(entity);
  }

  /// Variant of `save` that maps errors to localized messages and logs them.
  Future<void> saveWithContext(
      SettingsEntity entity, BuildContext context) async {
    final tr = context.tr;
    try {
      await runWithErrorHandling(() => save(entity),
          localizations: tr, rethrowOnError: true);
    } catch (e, st) {
      final message = mapErrorToMessage(e, tr);
      developer.log('Settings save failed: $message',
          name: 'SettingsFeatureCubit', error: e, stackTrace: st);
      rethrow;
    }
  }
}
