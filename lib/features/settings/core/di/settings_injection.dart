import 'package:hive_flutter/hive_flutter.dart';

import '../../data/datasource/local/settings_local_data_source.dart';
import '../../data/mapper/settings_mapper.dart';
import '../../data/repository/settings_repo_impl.dart';
import '../../domain/use_case/settings_uc.dart';

/// Simple DI helper for the settings feature.
SettingsFeatureUC createSettingsFeatureUseCase() {
  final box = Hive.box('settings');
  final local = SettingsLocalDataSource(box: box);
  const mapper = SettingsMapper();
  final repo = SettingsFeatureRepoImpl(local: local, mapper: mapper);
  return SettingsFeatureUC(repo);
}
