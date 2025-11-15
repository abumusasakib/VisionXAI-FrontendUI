import 'package:equatable/equatable.dart';

/// Generic entity used by the generated feature.
/// Keeps an optional `id` and an attributes map so projects can extend easily.
class SampleFeatureEntity extends Equatable {
  final String? id;
  final Map<String, dynamic> attributes;

  const SampleFeatureEntity({this.id, this.attributes = const {}});

  factory SampleFeatureEntity.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return SampleFeatureEntity(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  @override
  List<Object?> get props => [id, attributes];
}
