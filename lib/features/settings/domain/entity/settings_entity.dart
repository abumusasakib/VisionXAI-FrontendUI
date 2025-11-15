class SettingsEntity {
  final String ip;
  final String port;
  final String locale;

  const SettingsEntity(
      {required this.ip, required this.port, required this.locale});

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'port': port,
        'locale': locale,
      };

  factory SettingsEntity.fromJson(Map<String, dynamic> json) => SettingsEntity(
        ip: json['ip'] as String? ?? '127.0.0.1',
        port: json['port'] as String? ?? '8000',
        locale: json['locale'] as String? ?? 'en',
      );
}
