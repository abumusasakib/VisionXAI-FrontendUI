import 'package:flutter_test/flutter_test.dart';
import 'package:vision_xai/features/settings/domain/entity/settings_entity.dart';
import 'package:vision_xai/features/settings/domain/use_case/settings_uc.dart';
import 'package:vision_xai/features/settings/presentation/cubit/settings_feature_cubit.dart';

class _FakeUC implements SettingsFeatureUC {
  SettingsEntity stored;
  _FakeUC(this.stored);

  @override
  Future<SettingsEntity> load() async => stored;

  @override
  Future<void> save(SettingsEntity entity) async {
    stored = entity;
  }
}

void main() {
  test('SettingsFeatureCubit emits on load and save', () async {
    final uc = _FakeUC(
        const SettingsEntity(ip: '127.0.0.1', port: '8000', locale: 'en'));
    final cubit = SettingsFeatureCubit(uc);

    final emits = <SettingsEntity?>[];
    final sub = cubit.stream.listen(emits.add);

    await cubit.load();
    // allow event loop to deliver stream events
    await Future.delayed(Duration.zero);
    expect(emits.last?.ip, '127.0.0.1');

    const newEntity = SettingsEntity(ip: '9.9.9.9', port: '9000', locale: 'bn');
    await cubit.save(newEntity);
    await Future.delayed(Duration.zero);
    expect(emits.last?.ip, '9.9.9.9');

    await sub.cancel();
    await cubit.close();
  });
}
