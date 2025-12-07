// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_caption_entity_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageCaptionEntityGroup {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageCaptionEntityGroup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageCaptionEntityGroup()';
}


}

/// @nodoc
class $ImageCaptionEntityGroupCopyWith<$Res>  {
$ImageCaptionEntityGroupCopyWith(ImageCaptionEntityGroup _, $Res Function(ImageCaptionEntityGroup) __);
}


/// Adds pattern-matching-related methods to [ImageCaptionEntityGroup].
extension ImageCaptionEntityGroupPatterns on ImageCaptionEntityGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Success value)?  success,TResult Function( _Unknown value)?  unKnown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that);case _Unknown() when unKnown != null:
return unKnown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Success value)  success,required TResult Function( _Unknown value)  unKnown,}){
final _that = this;
switch (_that) {
case _Success():
return success(_that);case _Unknown():
return unKnown(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Success value)?  success,TResult? Function( _Unknown value)?  unKnown,}){
final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that);case _Unknown() when unKnown != null:
return unKnown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ImageCaptionEntity entity)?  success,TResult Function()?  unKnown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that.entity);case _Unknown() when unKnown != null:
return unKnown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ImageCaptionEntity entity)  success,required TResult Function()  unKnown,}) {final _that = this;
switch (_that) {
case _Success():
return success(_that.entity);case _Unknown():
return unKnown();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ImageCaptionEntity entity)?  success,TResult? Function()?  unKnown,}) {final _that = this;
switch (_that) {
case _Success() when success != null:
return success(_that.entity);case _Unknown() when unKnown != null:
return unKnown();case _:
  return null;

}
}

}

/// @nodoc


class _Success implements ImageCaptionEntityGroup {
  const _Success(this.entity);
  

 final  ImageCaptionEntity entity;

/// Create a copy of ImageCaptionEntityGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.entity, entity) || other.entity == entity));
}


@override
int get hashCode => Object.hash(runtimeType,entity);

@override
String toString() {
  return 'ImageCaptionEntityGroup.success(entity: $entity)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $ImageCaptionEntityGroupCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 ImageCaptionEntity entity
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of ImageCaptionEntityGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? entity = null,}) {
  return _then(_Success(
null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as ImageCaptionEntity,
  ));
}


}

/// @nodoc


class _Unknown implements ImageCaptionEntityGroup {
  const _Unknown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unknown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageCaptionEntityGroup.unKnown()';
}


}




// dart format on
