// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_feature_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SampleFeatureModel {

 String? get id; Map<String, dynamic> get attributes;
/// Create a copy of SampleFeatureModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleFeatureModelCopyWith<SampleFeatureModel> get copyWith => _$SampleFeatureModelCopyWithImpl<SampleFeatureModel>(this as SampleFeatureModel, _$identity);

  /// Serializes this SampleFeatureModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleFeatureModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.attributes, attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(attributes));

@override
String toString() {
  return 'SampleFeatureModel(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class $SampleFeatureModelCopyWith<$Res>  {
  factory $SampleFeatureModelCopyWith(SampleFeatureModel value, $Res Function(SampleFeatureModel) _then) = _$SampleFeatureModelCopyWithImpl;
@useResult
$Res call({
 String? id, Map<String, dynamic> attributes
});




}
/// @nodoc
class _$SampleFeatureModelCopyWithImpl<$Res>
    implements $SampleFeatureModelCopyWith<$Res> {
  _$SampleFeatureModelCopyWithImpl(this._self, this._then);

  final SampleFeatureModel _self;
  final $Res Function(SampleFeatureModel) _then;

/// Create a copy of SampleFeatureModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? attributes = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [SampleFeatureModel].
extension SampleFeatureModelPatterns on SampleFeatureModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SampleFeatureModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SampleFeatureModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SampleFeatureModel value)  $default,){
final _that = this;
switch (_that) {
case _SampleFeatureModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SampleFeatureModel value)?  $default,){
final _that = this;
switch (_that) {
case _SampleFeatureModel() when $default != null:
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
case _SampleFeatureModel() when $default != null:
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
case _SampleFeatureModel():
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
case _SampleFeatureModel() when $default != null:
return $default(_that.id,_that.attributes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SampleFeatureModel extends SampleFeatureModel {
  const _SampleFeatureModel({this.id, final  Map<String, dynamic> attributes = const <String, dynamic>{}}): _attributes = attributes,super._();
  factory _SampleFeatureModel.fromJson(Map<String, dynamic> json) => _$SampleFeatureModelFromJson(json);

@override final  String? id;
 final  Map<String, dynamic> _attributes;
@override@JsonKey() Map<String, dynamic> get attributes {
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributes);
}


/// Create a copy of SampleFeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SampleFeatureModelCopyWith<_SampleFeatureModel> get copyWith => __$SampleFeatureModelCopyWithImpl<_SampleFeatureModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SampleFeatureModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SampleFeatureModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._attributes, _attributes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_attributes));

@override
String toString() {
  return 'SampleFeatureModel(id: $id, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class _$SampleFeatureModelCopyWith<$Res> implements $SampleFeatureModelCopyWith<$Res> {
  factory _$SampleFeatureModelCopyWith(_SampleFeatureModel value, $Res Function(_SampleFeatureModel) _then) = __$SampleFeatureModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, Map<String, dynamic> attributes
});




}
/// @nodoc
class __$SampleFeatureModelCopyWithImpl<$Res>
    implements _$SampleFeatureModelCopyWith<$Res> {
  __$SampleFeatureModelCopyWithImpl(this._self, this._then);

  final _SampleFeatureModel _self;
  final $Res Function(_SampleFeatureModel) _then;

/// Create a copy of SampleFeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? attributes = null,}) {
  return _then(_SampleFeatureModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
