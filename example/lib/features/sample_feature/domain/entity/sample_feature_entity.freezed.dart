// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_feature_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SampleFeatureEntity _$SampleFeatureEntityFromJson(Map<String, dynamic> json) {
  return _SampleFeatureEntity.fromJson(json);
}

/// @nodoc
mixin _$SampleFeatureEntity {
  String? get id => throw _privateConstructorUsedError;
  Map<String, dynamic> get attributes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SampleFeatureEntityCopyWith<SampleFeatureEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleFeatureEntityCopyWith<$Res> {
  factory $SampleFeatureEntityCopyWith(
          SampleFeatureEntity value, $Res Function(SampleFeatureEntity) then) =
      _$SampleFeatureEntityCopyWithImpl<$Res, SampleFeatureEntity>;
  @useResult
  $Res call({String? id, Map<String, dynamic> attributes});
}

/// @nodoc
class _$SampleFeatureEntityCopyWithImpl<$Res, $Val extends SampleFeatureEntity>
    implements $SampleFeatureEntityCopyWith<$Res> {
  _$SampleFeatureEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attributes = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SampleFeatureEntityImplCopyWith<$Res>
    implements $SampleFeatureEntityCopyWith<$Res> {
  factory _$$SampleFeatureEntityImplCopyWith(_$SampleFeatureEntityImpl value,
          $Res Function(_$SampleFeatureEntityImpl) then) =
      __$$SampleFeatureEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, Map<String, dynamic> attributes});
}

/// @nodoc
class __$$SampleFeatureEntityImplCopyWithImpl<$Res>
    extends _$SampleFeatureEntityCopyWithImpl<$Res, _$SampleFeatureEntityImpl>
    implements _$$SampleFeatureEntityImplCopyWith<$Res> {
  __$$SampleFeatureEntityImplCopyWithImpl(_$SampleFeatureEntityImpl _value,
      $Res Function(_$SampleFeatureEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attributes = null,
  }) {
    return _then(_$SampleFeatureEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SampleFeatureEntityImpl extends _SampleFeatureEntity {
  const _$SampleFeatureEntityImpl(
      {this.id,
      final Map<String, dynamic> attributes = const <String, dynamic>{}})
      : _attributes = attributes,
        super._();

  factory _$SampleFeatureEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$SampleFeatureEntityImplFromJson(json);

  @override
  final String? id;
  final Map<String, dynamic> _attributes;
  @override
  @JsonKey()
  Map<String, dynamic> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

  @override
  String toString() {
    return 'SampleFeatureEntity(id: $id, attributes: $attributes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleFeatureEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_attributes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SampleFeatureEntityImplCopyWith<_$SampleFeatureEntityImpl> get copyWith =>
      __$$SampleFeatureEntityImplCopyWithImpl<_$SampleFeatureEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SampleFeatureEntityImplToJson(
      this,
    );
  }
}

abstract class _SampleFeatureEntity extends SampleFeatureEntity {
  const factory _SampleFeatureEntity(
      {final String? id,
      final Map<String, dynamic> attributes}) = _$SampleFeatureEntityImpl;
  const _SampleFeatureEntity._() : super._();

  factory _SampleFeatureEntity.fromJson(Map<String, dynamic> json) =
      _$SampleFeatureEntityImpl.fromJson;

  @override
  String? get id;
  @override
  Map<String, dynamic> get attributes;
  @override
  @JsonKey(ignore: true)
  _$$SampleFeatureEntityImplCopyWith<_$SampleFeatureEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
