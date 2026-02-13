// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_feature_attributes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SampleFeatureAttributes {

/// Example field - replace with your actual attributes
 String? get caption; double? get confidence;
/// Create a copy of SampleFeatureAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleFeatureAttributesCopyWith<SampleFeatureAttributes> get copyWith => _$SampleFeatureAttributesCopyWithImpl<SampleFeatureAttributes>(this as SampleFeatureAttributes, _$identity);

  /// Serializes this SampleFeatureAttributes to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleFeatureAttributes&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,caption,confidence);

@override
String toString() {
  return 'SampleFeatureAttributes(caption: $caption, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $SampleFeatureAttributesCopyWith<$Res>  {
  factory $SampleFeatureAttributesCopyWith(SampleFeatureAttributes value, $Res Function(SampleFeatureAttributes) _then) = _$SampleFeatureAttributesCopyWithImpl;
@useResult
$Res call({
 String? caption, double? confidence
});




}
/// @nodoc
class _$SampleFeatureAttributesCopyWithImpl<$Res>
    implements $SampleFeatureAttributesCopyWith<$Res> {
  _$SampleFeatureAttributesCopyWithImpl(this._self, this._then);

  final SampleFeatureAttributes _self;
  final $Res Function(SampleFeatureAttributes) _then;

/// Create a copy of SampleFeatureAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? caption = freezed,Object? confidence = freezed,}) {
  return _then(_self.copyWith(
caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SampleFeatureAttributes].
extension SampleFeatureAttributesPatterns on SampleFeatureAttributes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SampleFeatureAttributes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SampleFeatureAttributes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SampleFeatureAttributes value)  $default,){
final _that = this;
switch (_that) {
case _SampleFeatureAttributes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SampleFeatureAttributes value)?  $default,){
final _that = this;
switch (_that) {
case _SampleFeatureAttributes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? caption,  double? confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SampleFeatureAttributes() when $default != null:
return $default(_that.caption,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? caption,  double? confidence)  $default,) {final _that = this;
switch (_that) {
case _SampleFeatureAttributes():
return $default(_that.caption,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? caption,  double? confidence)?  $default,) {final _that = this;
switch (_that) {
case _SampleFeatureAttributes() when $default != null:
return $default(_that.caption,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SampleFeatureAttributes implements SampleFeatureAttributes {
  const _SampleFeatureAttributes({this.caption, this.confidence});
  factory _SampleFeatureAttributes.fromJson(Map<String, dynamic> json) => _$SampleFeatureAttributesFromJson(json);

/// Example field - replace with your actual attributes
@override final  String? caption;
@override final  double? confidence;

/// Create a copy of SampleFeatureAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleFeatureAttributesCopyWith<_SampleFeatureAttributes> get copyWith => __$SampleFeatureAttributesCopyWithImpl<_SampleFeatureAttributes>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SampleFeatureAttributesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SampleFeatureAttributes&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,caption,confidence);

@override
String toString() {
  return 'SampleFeatureAttributes(caption: $caption, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$SampleFeatureAttributesCopyWith<$Res> implements $SampleFeatureAttributesCopyWith<$Res> {
  factory _$SampleFeatureAttributesCopyWith(_SampleFeatureAttributes value, $Res Function(_SampleFeatureAttributes) _then) = __$SampleFeatureAttributesCopyWithImpl;
@override @useResult
$Res call({
 String? caption, double? confidence
});




}
/// @nodoc
class __$SampleFeatureAttributesCopyWithImpl<$Res>
    implements _$SampleFeatureAttributesCopyWith<$Res> {
  __$SampleFeatureAttributesCopyWithImpl(this._self, this._then);

  final _SampleFeatureAttributes _self;
  final $Res Function(_SampleFeatureAttributes) _then;

/// Create a copy of SampleFeatureAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? caption = freezed,Object? confidence = freezed,}) {
  return _then(_SampleFeatureAttributes(
caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
