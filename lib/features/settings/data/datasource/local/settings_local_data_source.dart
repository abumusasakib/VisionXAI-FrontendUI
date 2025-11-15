import 'package:hive_flutter/hive_flutter.dart';
import 'package:vision_xai/core/constants/ip_details.dart';
import 'package:vision_xai/l10n/app_localizations.dart';

import '../../model/settings_model.dart';

class SettingsLocalDataSource {
  final Box box;

  SettingsLocalDataSource({required this.box});

  Future<SettingsModel> load() async {
    // Read keys explicitly to avoid accidental coupling with other keys in the box
    final ip = box.get('ip', defaultValue: IPDetails.defaultIP)?.toString();
    final port =
        box.get('port', defaultValue: IPDetails.defaultPort)?.toString();
    final locale = box
        .get('locale',
            defaultValue: AppLocalizations.supportedLocales.first.languageCode)
        ?.toString();

    return SettingsModel.fromJson({
      'ip': ip,
      'port': port,
      'locale': locale,
    });
  }

  Future<void> save(SettingsModel model) async {
    await box.putAll(model.toJson());
  }
}
