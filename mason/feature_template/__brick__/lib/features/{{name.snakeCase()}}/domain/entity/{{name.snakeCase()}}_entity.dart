import 'package:equatable/equatable.dart';

/// Generic entity used by the generated feature.
/// Keeps an optional `id` and an attributes map so projects can extend easily.
class {{name.pascalCase()}}Entity extends Equatable {
  final String? id;
  final Map<String, dynamic> attributes;

  const {{name.pascalCase()}}Entity({this.id, this.attributes = const {}});

  factory {{name.pascalCase()}}Entity.fromMap(Map<String, dynamic> map) {
    final mapCopy = Map<String, dynamic>.from(map);
    final id = mapCopy.remove('id')?.toString();
    return {{name.pascalCase()}}Entity(id: id, attributes: mapCopy);
  }

  Map<String, dynamic> toMap() => {'id': id, ...attributes};

  @override
  List<Object?> get props => [id, attributes];
}
