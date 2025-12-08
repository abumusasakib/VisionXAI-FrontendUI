// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_feature_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SampleFeatureResponseDto _$SampleFeatureResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _SampleFeatureResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SampleFeatureResponseDto {
  String get caption => throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SampleFeatureResponseDtoCopyWith<SampleFeatureResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleFeatureResponseDtoCopyWith<$Res> {
  factory $SampleFeatureResponseDtoCopyWith(SampleFeatureResponseDto value,
          $Res Function(SampleFeatureResponseDto) then) =
      _$SampleFeatureResponseDtoCopyWithImpl<$Res, SampleFeatureResponseDto>;
  @useResult
  $Res call({String caption, double? confidence, String? id, int? statusCode});
}

/// @nodoc
class _$SampleFeatureResponseDtoCopyWithImpl<$Res,
        $Val extends SampleFeatureResponseDto>
    implements $SampleFeatureResponseDtoCopyWith<$Res> {
  _$SampleFeatureResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caption = null,
    Object? confidence = freezed,
    Object? id = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_value.copyWith(
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SampleFeatureResponseDtoImplCopyWith<$Res>
    implements $SampleFeatureResponseDtoCopyWith<$Res> {
  factory _$$SampleFeatureResponseDtoImplCopyWith(
          _$SampleFeatureResponseDtoImpl value,
          $Res Function(_$SampleFeatureResponseDtoImpl) then) =
      __$$SampleFeatureResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String caption, double? confidence, String? id, int? statusCode});
}

/// @nodoc
class __$$SampleFeatureResponseDtoImplCopyWithImpl<$Res>
    extends _$SampleFeatureResponseDtoCopyWithImpl<$Res,
        _$SampleFeatureResponseDtoImpl>
    implements _$$SampleFeatureResponseDtoImplCopyWith<$Res> {
  __$$SampleFeatureResponseDtoImplCopyWithImpl(
      _$SampleFeatureResponseDtoImpl _value,
      $Res Function(_$SampleFeatureResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caption = null,
    Object? confidence = freezed,
    Object? id = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_$SampleFeatureResponseDtoImpl(
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SampleFeatureResponseDtoImpl extends _SampleFeatureResponseDto {
  const _$SampleFeatureResponseDtoImpl(
      {required this.caption, this.confidence, this.id, this.statusCode})
      : super._();

  factory _$SampleFeatureResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SampleFeatureResponseDtoImplFromJson(json);

  @override
  final String caption;
  @override
  final double? confidence;
  @override
  final String? id;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'SampleFeatureResponseDto(caption: $caption, confidence: $confidence, id: $id, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleFeatureResponseDtoImpl &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, caption, confidence, id, statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SampleFeatureResponseDtoImplCopyWith<_$SampleFeatureResponseDtoImpl>
      get copyWith => __$$SampleFeatureResponseDtoImplCopyWithImpl<
          _$SampleFeatureResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SampleFeatureResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _SampleFeatureResponseDto extends SampleFeatureResponseDto {
  const factory _SampleFeatureResponseDto(
      {required final String caption,
      final double? confidence,
      final String? id,
      final int? statusCode}) = _$SampleFeatureResponseDtoImpl;
  const _SampleFeatureResponseDto._() : super._();

  factory _SampleFeatureResponseDto.fromJson(Map<String, dynamic> json) =
      _$SampleFeatureResponseDtoImpl.fromJson;

  @override
  String get caption;
  @override
  double? get confidence;
  @override
  String? get id;
  @override
  int? get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$SampleFeatureResponseDtoImplCopyWith<_$SampleFeatureResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
