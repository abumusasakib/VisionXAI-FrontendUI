class AboutState {
  final String appVersion;
  final String platform;

  const AboutState({required this.appVersion, required this.platform});

  factory AboutState.loading() =>
      const AboutState(appVersion: 'Loading...', platform: 'Unknown');
}
