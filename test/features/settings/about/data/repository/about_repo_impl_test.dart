import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:vision_xai/features/settings/about/data/repository/about_repo_impl.dart';
import 'package:vision_xai/features/settings/about/data/datasource/about_local_data_source.dart';
import 'package:vision_xai/features/settings/about/data/mapper/about_mapper.dart';

void main() {
  test('AboutRepoImpl.loadAppInfo returns non-empty values', () async {
    // Ensure Flutter bindings are initialized so platform channels work
    final binding = TestWidgetsFlutterBinding.ensureInitialized();

    // Mock the package_info_plus platform channel so PackageInfo.fromPlatform
    // returns predictable values in tests.
    const channelName = 'dev.fluttercommunity.plus/package_info';
    const methodChannel = MethodChannel(channelName);
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      methodChannel,
      (call) async {
        if (call.method == 'getAll') {
          return {
            'appName': 'test',
            'packageName': 'test.pkg',
            'version': '1.2.3',
            'buildNumber': '4',
            'buildSignature': ''
          };
        }
        return null;
      },
    );
    const local = AboutLocalDataSourceImpl();
    const mapper = AboutMapper();
    final repo = AboutRepoImpl(local, mapper);

    final result = await repo.loadAppInfo();

    expect(result.appVersion, isNotEmpty);
    expect(result.platform, isNotNull);
    expect(result.platform, isNotEmpty);
  });
}
