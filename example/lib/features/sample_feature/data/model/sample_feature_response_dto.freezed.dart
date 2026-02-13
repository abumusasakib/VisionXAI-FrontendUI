// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_feature_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SampleFeatureResponseDto {

 String get caption; double? get confidence; String? get id; int? get statusCode;
/// Create a copy of SampleFeatureResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleFeatureResponseDtoCopyWith<SampleFeatureResponseDto> get copyWith => _$SampleFeatureResponseDtoCopyWithImpl<SampleFeatureResponseDto>(this as SampleFeatureResponseDto, _$identity);

  /// Serializes this SampleFeatureResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleFeatureResponseDto&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.id, id) || other.id == id)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,caption,confidence,id,statusCode);

@override
String toString() {
  return 'SampleFeatureResponseDto(caption: $caption, confidence: $confidence, id: $id, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $SampleFeatureResponseDtoCopyWith<$Res>  {
  factory $SampleFeatureResponseDtoCopyWith(SampleFeatureResponseDto value, $Res Function(SampleFeatureResponseDto) _then) = _$SampleFeatureResponseDtoCopyWithImpl;
@useResult
$Res call({
 String caption, double? confidence, String? id, int? statusCode
});




}
/// @nodoc
class _$SampleFeatureResponseDtoCopyWithImpl<$Res>
    implements $SampleFeatureResponseDtoCopyWith<$Res> {
  _$SampleFeatureResponseDtoCopyWithImpl(this._self, this._then);

  final SampleFeatureResponseDto _self;
  final $Res Function(SampleFeatureResponseDto) _then;

/// Create a copy of SampleFeatureResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? caption = null,Object? confidence = freezed,Object? id = freezed,Object? statusCode = freezed,}) {
  return _then(_self.copyWith(
caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SampleFeatureResponseDto].
extension SampleFeatureResponseDtoPatterns on SampleFeatureResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SampleFeatureResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SampleFeatureResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SampleFeatureResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _SampleFeatureResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SampleFeatureResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _SampleFeatureResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String caption,  double? confidence,  String? id,  int? statusCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SampleFeatureResponseDto() when $default != null:
return $default(_that.caption,_that.confidence,_that.id,_that.statusCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String caption,  double? confidence,  String? id,  int? statusCode)  $default,) {final _that = this;
switch (_that) {
case _SampleFeatureResponseDto():
return $default(_that.caption,_that.confidence,_that.id,_that.statusCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String caption,  double? confidence,  String? id,  int? statusCode)?  $default,) {final _that = this;
switch (_that) {
case _SampleFeatureResponseDto() when $default != null:
return $default(_that.caption,_that.confidence,_that.id,_that.statusCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SampleFeatureResponseDto extends SampleFeatureResponseDto {
  const _SampleFeatureResponseDto({required this.caption, this.confidence, this.id, this.statusCode}): super._();
  factory _SampleFeatureResponseDto.fromJson(Map<String, dynamic> json) => _$SampleFeatureResponseDtoFromJson(json);

@override final  String caption;
@override final  double? confidence;
@override final  String? id;
@override final  int? statusCode;

/// Create a copy of SampleFeatureResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleFeatureResponseDtoCopyWith<_SampleFeatureResponseDto> get copyWith => __$SampleFeatureResponseDtoCopyWithImpl<_SampleFeatureResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SampleFeatureResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SampleFeatureResponseDto&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.id, id) || other.id == id)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,caption,confidence,id,statusCode);

@override
String toString() {
  return 'SampleFeatureResponseDto(caption: $caption, confidence: $confidence, id: $id, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$SampleFeatureResponseDtoCopyWith<$Res> implements $SampleFeatureResponseDtoCopyWith<$Res> {
  factory _$SampleFeatureResponseDtoCopyWith(_SampleFeatureResponseDto value, $Res Function(_SampleFeatureResponseDto) _then) = __$SampleFeatureResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String caption, double? confidence, String? id, int? statusCode
});




}
/// @nodoc
class __$SampleFeatureResponseDtoCopyWithImpl<$Res>
    implements _$SampleFeatureResponseDtoCopyWith<$Res> {
  __$SampleFeatureResponseDtoCopyWithImpl(this._self, this._then);

  final _SampleFeatureResponseDto _self;
  final $Res Function(_SampleFeatureResponseDto) _then;

/// Create a copy of SampleFeatureResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? caption = null,Object? confidence = freezed,Object? id = freezed,Object? statusCode = freezed,}) {
  return _then(_SampleFeatureResponseDto(
caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
