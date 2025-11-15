import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../model/about_model.dart';

/// Data source that reads app info from platform APIs.
abstract class AboutLocalDataSource {
  Future<AboutModel> fetchAppInfo();
}

class AboutLocalDataSourceImpl implements AboutLocalDataSource {
  const AboutLocalDataSourceImpl();

  @override
  Future<AboutModel> fetchAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    String platformName = 'Unknown';
    try {
      if (kIsWeb) {
        platformName = 'Web';
      } else if (Platform.isAndroid) {
        platformName = 'Android';
      } else if (Platform.isIOS) {
        platformName = 'iOS';
      } else if (Platform.isLinux) {
        platformName = 'Linux';
      } else if (Platform.isMacOS) {
        platformName = 'macOS';
      } else if (Platform.isWindows) {
        platformName = 'Windows';
      }
    } catch (_) {
      platformName = 'Unsupported Platform';
    }

    final appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    return AboutModel(appVersion: appVersion, platform: platformName);
  }
}
