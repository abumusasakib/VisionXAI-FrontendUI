// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_caption_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageCaptionModel {

 String? get id; Map<String, dynamic> get attributes;
/// Create a copy of ImageCaptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageCaptionModelCopyWith<ImageCaptionModel> get copyWith => _$ImageCaptionModelCopyWithImpl<ImageCaptionModel>(this as ImageCaptionModel, _$identity);

  /// Serializes this ImageCaptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageCaptionModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.attributes, attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(attributes));

@override
String toString() {
  return 'ImageCaptionModel(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $ImageCaptionModelCopyWith<$Res>  {
  factory $ImageCaptionModelCopyWith(ImageCaptionModel value, $Res Function(ImageCaptionModel) _then) = _$ImageCaptionModelCopyWithImpl;
@useResult
$Res call({
 String? id, Map<String, dynamic> attributes
});




}
/// @nodoc
class _$ImageCaptionModelCopyWithImpl<$Res>
    implements $ImageCaptionModelCopyWith<$Res> {
  _$ImageCaptionModelCopyWithImpl(this._self, this._then);

  final ImageCaptionModel _self;
  final $Res Function(ImageCaptionModel) _then;

/// Create a copy of ImageCaptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? attributes = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageCaptionModel].
extension ImageCaptionModelPatterns on ImageCaptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageCaptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageCaptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageCaptionModel value)  $default,){
final _that = this;
switch (_that) {
case _ImageCaptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageCaptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ImageCaptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  Map<String, dynamic> attributes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageCaptionModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  Map<String, dynamic> attributes)  $default,) {final _that = this;
switch (_that) {
case _ImageCaptionModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  Map<String, dynamic> attributes)?  $default,) {final _that = this;
switch (_that) {
case _ImageCaptionModel() when $default != null:
return $default(_that.id,_that.attributes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageCaptionModel extends ImageCaptionModel {
  const _ImageCaptionModel({this.id, final  Map<String, dynamic> attributes = const <String, dynamic>{}}): _attributes = attributes,super._();
  factory _ImageCaptionModel.fromJson(Map<String, dynamic> json) => _$ImageCaptionModelFromJson(json);

@override final  String? id;
 final  Map<String, dynamic> _attributes;
@override@JsonKey() Map<String, dynamic> get attributes {
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributes);
}


/// Create a copy of ImageCaptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageCaptionModelCopyWith<_ImageCaptionModel> get copyWith => __$ImageCaptionModelCopyWithImpl<_ImageCaptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageCaptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageCaptionModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._attributes, _attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_attributes));

@override
String toString() {
  return 'ImageCaptionModel(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class _$ImageCaptionModelCopyWith<$Res> implements $ImageCaptionModelCopyWith<$Res> {
  factory _$ImageCaptionModelCopyWith(_ImageCaptionModel value, $Res Function(_ImageCaptionModel) _then) = __$ImageCaptionModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, Map<String, dynamic> attributes
});




}
/// @nodoc
class __$ImageCaptionModelCopyWithImpl<$Res>
    implements _$ImageCaptionModelCopyWith<$Res> {
  __$ImageCaptionModelCopyWithImpl(this._self, this._then);

  final _ImageCaptionModel _self;
  final $Res Function(_ImageCaptionModel) _then;

/// Create a copy of ImageCaptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? attributes = null,}) {
  return _then(_ImageCaptionModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
