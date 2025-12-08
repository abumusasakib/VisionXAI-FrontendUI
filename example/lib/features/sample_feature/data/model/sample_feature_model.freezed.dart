// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_feature_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SampleFeatureModel _$SampleFeatureModelFromJson(Map<String, dynamic> json) {
  return _SampleFeatureModel.fromJson(json);
}

/// @nodoc
mixin _$SampleFeatureModel {
  String? get id => throw _privateConstructorUsedError;
  Map<String, dynamic> get attributes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SampleFeatureModelCopyWith<SampleFeatureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleFeatureModelCopyWith<$Res> {
  factory $SampleFeatureModelCopyWith(
          SampleFeatureModel value, $Res Function(SampleFeatureModel) then) =
      _$SampleFeatureModelCopyWithImpl<$Res, SampleFeatureModel>;
  @useResult
  $Res call({String? id, Map<String, dynamic> attributes});
}

/// @nodoc
class _$SampleFeatureModelCopyWithImpl<$Res, $Val extends SampleFeatureModel>
    implements $SampleFeatureModelCopyWith<$Res> {
  _$SampleFeatureModelCopyWithImpl(this._value, this._then);

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
abstract class _$$SampleFeatureModelImplCopyWith<$Res>
    implements $SampleFeatureModelCopyWith<$Res> {
  factory _$$SampleFeatureModelImplCopyWith(_$SampleFeatureModelImpl value,
          $Res Function(_$SampleFeatureModelImpl) then) =
      __$$SampleFeatureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, Map<String, dynamic> attributes});
}

/// @nodoc
class __$$SampleFeatureModelImplCopyWithImpl<$Res>
    extends _$SampleFeatureModelCopyWithImpl<$Res, _$SampleFeatureModelImpl>
    implements _$$SampleFeatureModelImplCopyWith<$Res> {
  __$$SampleFeatureModelImplCopyWithImpl(_$SampleFeatureModelImpl _value,
      $Res Function(_$SampleFeatureModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attributes = null,
  }) {
    return _then(_$SampleFeatureModelImpl(
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
class _$SampleFeatureModelImpl extends _SampleFeatureModel {
  const _$SampleFeatureModelImpl(
      {this.id,
      final Map<String, dynamic> attributes = const <String, dynamic>{}})
      : _attributes = attributes,
        super._();

  factory _$SampleFeatureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SampleFeatureModelImplFromJson(json);

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
    return 'SampleFeatureModel(id: $id, attributes: $attributes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleFeatureModelImpl &&
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
  _$$SampleFeatureModelImplCopyWith<_$SampleFeatureModelImpl> get copyWith =>
      __$$SampleFeatureModelImplCopyWithImpl<_$SampleFeatureModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SampleFeatureModelImplToJson(
      this,
    );
  }
}

abstract class _SampleFeatureModel extends SampleFeatureModel {
  const factory _SampleFeatureModel(
      {final String? id,
      final Map<String, dynamic> attributes}) = _$SampleFeatureModelImpl;
  const _SampleFeatureModel._() : super._();

  factory _SampleFeatureModel.fromJson(Map<String, dynamic> json) =
      _$SampleFeatureModelImpl.fromJson;

  @override
  String? get id;
  @override
  Map<String, dynamic> get attributes;
  @override
  @JsonKey(ignore: true)
  _$$SampleFeatureModelImplCopyWith<_$SampleFeatureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
