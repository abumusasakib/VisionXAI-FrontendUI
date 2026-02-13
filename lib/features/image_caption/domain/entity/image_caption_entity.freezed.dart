// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_caption_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageCaptionEntity {

 String? get id; ImageCaptionAttributes get attributes;
/// Create a copy of ImageCaptionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageCaptionEntityCopyWith<ImageCaptionEntity> get copyWith => _$ImageCaptionEntityCopyWithImpl<ImageCaptionEntity>(this as ImageCaptionEntity, _$identity);

  /// Serializes this ImageCaptionEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageCaptionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString() {
  return 'ImageCaptionEntity(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $ImageCaptionEntityCopyWith<$Res>  {
  factory $ImageCaptionEntityCopyWith(ImageCaptionEntity value, $Res Function(ImageCaptionEntity) _then) = _$ImageCaptionEntityCopyWithImpl;
@useResult
$Res call({
 String? id, ImageCaptionAttributes attributes
});


$ImageCaptionAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class _$ImageCaptionEntityCopyWithImpl<$Res>
    implements $ImageCaptionEntityCopyWith<$Res> {
  _$ImageCaptionEntityCopyWithImpl(this._self, this._then);

  final ImageCaptionEntity _self;
  final $Res Function(ImageCaptionEntity) _then;

/// Create a copy of ImageCaptionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? attributes = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as ImageCaptionAttributes,
  ));
}
/// Create a copy of ImageCaptionEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageCaptionAttributesCopyWith<$Res> get attributes {
  
  return $ImageCaptionAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// Adds pattern-matching-related methods to [ImageCaptionEntity].
extension ImageCaptionEntityPatterns on ImageCaptionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageCaptionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageCaptionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageCaptionEntity value)  $default,){
final _that = this;
switch (_that) {
case _ImageCaptionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageCaptionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ImageCaptionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  ImageCaptionAttributes attributes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageCaptionEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  ImageCaptionAttributes attributes)  $default,) {final _that = this;
switch (_that) {
case _ImageCaptionEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  ImageCaptionAttributes attributes)?  $default,) {final _that = this;
switch (_that) {
case _ImageCaptionEntity() when $default != null:
return $default(_that.id,_that.attributes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageCaptionEntity extends ImageCaptionEntity {
  const _ImageCaptionEntity({this.id, required this.attributes}): super._();
  factory _ImageCaptionEntity.fromJson(Map<String, dynamic> json) => _$ImageCaptionEntityFromJson(json);

@override final  String? id;
@override final  ImageCaptionAttributes attributes;

/// Create a copy of ImageCaptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageCaptionEntityCopyWith<_ImageCaptionEntity> get copyWith => __$ImageCaptionEntityCopyWithImpl<_ImageCaptionEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageCaptionEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageCaptionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.attributes, attributes) || other.attributes == attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,attributes);

@override
String toString() {
  return 'ImageCaptionEntity(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class _$ImageCaptionEntityCopyWith<$Res> implements $ImageCaptionEntityCopyWith<$Res> {
  factory _$ImageCaptionEntityCopyWith(_ImageCaptionEntity value, $Res Function(_ImageCaptionEntity) _then) = __$ImageCaptionEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, ImageCaptionAttributes attributes
});


@override $ImageCaptionAttributesCopyWith<$Res> get attributes;

}
/// @nodoc
class __$ImageCaptionEntityCopyWithImpl<$Res>
    implements _$ImageCaptionEntityCopyWith<$Res> {
  __$ImageCaptionEntityCopyWithImpl(this._self, this._then);

  final _ImageCaptionEntity _self;
  final $Res Function(_ImageCaptionEntity) _then;

/// Create a copy of ImageCaptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? attributes = null,}) {
  return _then(_ImageCaptionEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as ImageCaptionAttributes,
  ));
}

/// Create a copy of ImageCaptionEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageCaptionAttributesCopyWith<$Res> get attributes {
  
  return $ImageCaptionAttributesCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}

// dart format on
