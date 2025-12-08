import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vision_xai/core/constants/ip_details.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel(
      {required String ip,
      required String port,
      required String locale}) = _SettingsModel;

  const SettingsModel._();

  /// Preserve existing behavior: create from a Map and apply defaults.
  factory SettingsModel.fromMap(Map<String, dynamic> json) => SettingsModel(
        ip: json['ip'] as String? ?? IPDetails.defaultIP,
        port: json['port'] as String? ?? IPDetails.defaultPort,
        locale: json['locale'] as String? ??
            AppLocalizations.supportedLocales.first.languageCode,
      );

  /// JSON factory used by generated code.
  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
