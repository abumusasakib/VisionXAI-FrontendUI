import 'package:vision_xai/core/constants/ip_details.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

class SettingsModel {
  final String ip;
  final String port;
  final String locale;

  const SettingsModel(
      {required this.ip, required this.port, required this.locale});

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'port': port,
        'locale': locale,
      };

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        ip: json['ip'] as String? ?? IPDetails.defaultIP,
        port: json['port'] as String? ?? IPDetails.defaultPort,
        locale: json['locale'] as String? ??
            AppLocalizations.supportedLocales.first.languageCode,
      );
}
