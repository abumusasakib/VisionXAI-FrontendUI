// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsEntity {

 String get ip; String get port; String get locale;
/// Create a copy of SettingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsEntityCopyWith<SettingsEntity> get copyWith => _$SettingsEntityCopyWithImpl<SettingsEntity>(this as SettingsEntity, _$identity);

  /// Serializes this SettingsEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEntity&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.port, port) || other.port == port)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ip,port,locale);

@override
String toString() {
  return 'SettingsEntity(ip: $ip, port: $port, locale: $locale)';
}


}

/// @nodoc
abstract mixin class $SettingsEntityCopyWith<$Res>  {
  factory $SettingsEntityCopyWith(SettingsEntity value, $Res Function(SettingsEntity) _then) = _$SettingsEntityCopyWithImpl;
@useResult
$Res call({
 String ip, String port, String locale
});




}
/// @nodoc
class _$SettingsEntityCopyWithImpl<$Res>
    implements $SettingsEntityCopyWith<$Res> {
  _$SettingsEntityCopyWithImpl(this._self, this._then);

  final SettingsEntity _self;
  final $Res Function(SettingsEntity) _then;

/// Create a copy of SettingsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ip = null,Object? port = null,Object? locale = null,}) {
  return _then(_self.copyWith(
ip: null == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsEntity].
extension SettingsEntityPatterns on SettingsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _SettingsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ip,  String port,  String locale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsEntity() when $default != null:
return $default(_that.ip,_that.port,_that.locale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ip,  String port,  String locale)  $default,) {final _that = this;
switch (_that) {
case _SettingsEntity():
return $default(_that.ip,_that.port,_that.locale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ip,  String port,  String locale)?  $default,) {final _that = this;
switch (_that) {
case _SettingsEntity() when $default != null:
return $default(_that.ip,_that.port,_that.locale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsEntity extends SettingsEntity {
  const _SettingsEntity({required this.ip, required this.port, required this.locale}): super._();
  factory _SettingsEntity.fromJson(Map<String, dynamic> json) => _$SettingsEntityFromJson(json);

@override final  String ip;
@override final  String port;
@override final  String locale;

/// Create a copy of SettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsEntityCopyWith<_SettingsEntity> get copyWith => __$SettingsEntityCopyWithImpl<_SettingsEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsEntity&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.port, port) || other.port == port)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ip,port,locale);

@override
String toString() {
  return 'SettingsEntity(ip: $ip, port: $port, locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$SettingsEntityCopyWith<$Res> implements $SettingsEntityCopyWith<$Res> {
  factory _$SettingsEntityCopyWith(_SettingsEntity value, $Res Function(_SettingsEntity) _then) = __$SettingsEntityCopyWithImpl;
@override @useResult
$Res call({
 String ip, String port, String locale
});




}
/// @nodoc
class __$SettingsEntityCopyWithImpl<$Res>
    implements _$SettingsEntityCopyWith<$Res> {
  __$SettingsEntityCopyWithImpl(this._self, this._then);

  final _SettingsEntity _self;
  final $Res Function(_SettingsEntity) _then;

/// Create a copy of SettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ip = null,Object? port = null,Object? locale = null,}) {
  return _then(_SettingsEntity(
ip: null == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
