// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_feature_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SampleFeatureEntity {

 String? get id; SampleFeatureAttributes get attributes;
/// Create a copy of SampleFeatureEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleFeatureEntityCopyWith<SampleFeatureEntity> get copyWith => _$SampleFeatureEntityCopyWithImpl<SampleFeatureEntity>(this as SampleFeatureEntity, _$identity);

  /// Serializes this SampleFeatureEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleFeatureEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString() {
  return 'SampleFeatureEntity(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $SampleFeatureEntityCopyWith<$Res>  {
  factory $SampleFeatureEntityCopyWith(SampleFeatureEntity value, $Res Function(SampleFeatureEntity) _then) = _$SampleFeatureEntityCopyWithImpl;
@useResult
$Res call({
 String? id, SampleFeatureAttributes attributes
});


$SampleFeatureAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class _$SampleFeatureEntityCopyWithImpl<$Res>
    implements $SampleFeatureEntityCopyWith<$Res> {
  _$SampleFeatureEntityCopyWithImpl(this._self, this._then);

  final SampleFeatureEntity _self;
  final $Res Function(SampleFeatureEntity) _then;

/// Create a copy of SampleFeatureEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? attributes = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as SampleFeatureAttributes,
  ));
}
/// Create a copy of SampleFeatureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SampleFeatureAttributesCopyWith<$Res> get attributes {
  
  return $SampleFeatureAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// Adds pattern-matching-related methods to [SampleFeatureEntity].
extension SampleFeatureEntityPatterns on SampleFeatureEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SampleFeatureEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SampleFeatureEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SampleFeatureEntity value)  $default,){
final _that = this;
switch (_that) {
case _SampleFeatureEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SampleFeatureEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SampleFeatureEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  SampleFeatureAttributes attributes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SampleFeatureEntity() when $default != null:
return $default(_that.id,_that.attributes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  SampleFeatureAttributes attributes)  $default,) {final _that = this;
switch (_that) {
case _SampleFeatureEntity():
return $default(_that.id,_that.attributes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  SampleFeatureAttributes attributes)?  $default,) {final _that = this;
switch (_that) {
case _SampleFeatureEntity() when $default != null:
return $default(_that.id,_that.attributes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SampleFeatureEntity extends SampleFeatureEntity {
  const _SampleFeatureEntity({this.id, required this.attributes}): super._();
  factory _SampleFeatureEntity.fromJson(Map<String, dynamic> json) => _$SampleFeatureEntityFromJson(json);

@override final  String? id;
@override final  SampleFeatureAttributes attributes;

/// Create a copy of SampleFeatureEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleFeatureEntityCopyWith<_SampleFeatureEntity> get copyWith => __$SampleFeatureEntityCopyWithImpl<_SampleFeatureEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SampleFeatureEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SampleFeatureEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString() {
  return 'SampleFeatureEntity(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class _$SampleFeatureEntityCopyWith<$Res> implements $SampleFeatureEntityCopyWith<$Res> {
  factory _$SampleFeatureEntityCopyWith(_SampleFeatureEntity value, $Res Function(_SampleFeatureEntity) _then) = __$SampleFeatureEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, SampleFeatureAttributes attributes
});


@override $SampleFeatureAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class __$SampleFeatureEntityCopyWithImpl<$Res>
    implements _$SampleFeatureEntityCopyWith<$Res> {
  __$SampleFeatureEntityCopyWithImpl(this._self, this._then);

  final _SampleFeatureEntity _self;
  final $Res Function(_SampleFeatureEntity) _then;

/// Create a copy of SampleFeatureEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? attributes = null,}) {
  return _then(_SampleFeatureEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as SampleFeatureAttributes,
  ));
}

/// Create a copy of SampleFeatureEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SampleFeatureAttributesCopyWith<$Res> get attributes {
  
  return $SampleFeatureAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

// dart format on
