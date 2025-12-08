// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_caption_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageCaptionModel _$ImageCaptionModelFromJson(Map<String, dynamic> json) {
  return _ImageCaptionModel.fromJson(json);
}

/// @nodoc
mixin _$ImageCaptionModel {
  String? get id => throw _privateConstructorUsedError;
  Map<String, dynamic> get attributes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageCaptionModelCopyWith<ImageCaptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageCaptionModelCopyWith<$Res> {
  factory $ImageCaptionModelCopyWith(
          ImageCaptionModel value, $Res Function(ImageCaptionModel) then) =
      _$ImageCaptionModelCopyWithImpl<$Res, ImageCaptionModel>;
  @useResult
  $Res call({String? id, Map<String, dynamic> attributes});
}

/// @nodoc
class _$ImageCaptionModelCopyWithImpl<$Res, $Val extends ImageCaptionModel>
    implements $ImageCaptionModelCopyWith<$Res> {
  _$ImageCaptionModelCopyWithImpl(this._value, this._then);

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
abstract class _$$ImageCaptionModelImplCopyWith<$Res>
    implements $ImageCaptionModelCopyWith<$Res> {
  factory _$$ImageCaptionModelImplCopyWith(_$ImageCaptionModelImpl value,
          $Res Function(_$ImageCaptionModelImpl) then) =
      __$$ImageCaptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, Map<String, dynamic> attributes});
}

/// @nodoc
class __$$ImageCaptionModelImplCopyWithImpl<$Res>
    extends _$ImageCaptionModelCopyWithImpl<$Res, _$ImageCaptionModelImpl>
    implements _$$ImageCaptionModelImplCopyWith<$Res> {
  __$$ImageCaptionModelImplCopyWithImpl(_$ImageCaptionModelImpl _value,
      $Res Function(_$ImageCaptionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attributes = null,
  }) {
    return _then(_$ImageCaptionModelImpl(
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
class _$ImageCaptionModelImpl extends _ImageCaptionModel {
  const _$ImageCaptionModelImpl(
      {this.id,
      final Map<String, dynamic> attributes = const <String, dynamic>{}})
      : _attributes = attributes,
        super._();

  factory _$ImageCaptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageCaptionModelImplFromJson(json);

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
    return 'ImageCaptionModel(id: $id, attributes: $attributes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageCaptionModelImpl &&
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
  _$$ImageCaptionModelImplCopyWith<_$ImageCaptionModelImpl> get copyWith =>
      __$$ImageCaptionModelImplCopyWithImpl<_$ImageCaptionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageCaptionModelImplToJson(
      this,
    );
  }
}

abstract class _ImageCaptionModel extends ImageCaptionModel {
  const factory _ImageCaptionModel(
      {final String? id,
      final Map<String, dynamic> attributes}) = _$ImageCaptionModelImpl;
  const _ImageCaptionModel._() : super._();

  factory _ImageCaptionModel.fromJson(Map<String, dynamic> json) =
      _$ImageCaptionModelImpl.fromJson;

  @override
  String? get id;
  @override
  Map<String, dynamic> get attributes;
  @override
  @JsonKey(ignore: true)
  _$$ImageCaptionModelImplCopyWith<_$ImageCaptionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
