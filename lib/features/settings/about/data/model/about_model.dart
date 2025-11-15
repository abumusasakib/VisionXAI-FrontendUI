class AboutModel {
  final String appVersion;
  final String platform;

  const AboutModel({required this.appVersion, required this.platform});

  /// Convert to a JSON map (useful for debugging or persistence).
  Map<String, Object?> toJson() =>
      {'appVersion': appVersion, 'platform': platform};

  /// Create model from JSON map.
  factory AboutModel.fromJson(Map<String, Object?> json) => AboutModel(
        appVersion: json['appVersion'] as String? ?? '',
        platform: json['platform'] as String? ?? '',
      );
}
