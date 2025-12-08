// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'about_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AboutEntity _$AboutEntityFromJson(Map<String, dynamic> json) {
  return _AboutEntity.fromJson(json);
}

/// @nodoc
mixin _$AboutEntity {
  String get appVersion => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AboutEntityCopyWith<AboutEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AboutEntityCopyWith<$Res> {
  factory $AboutEntityCopyWith(
          AboutEntity value, $Res Function(AboutEntity) then) =
      _$AboutEntityCopyWithImpl<$Res, AboutEntity>;
  @useResult
  $Res call({String appVersion, String platform});
}

/// @nodoc
class _$AboutEntityCopyWithImpl<$Res, $Val extends AboutEntity>
    implements $AboutEntityCopyWith<$Res> {
  _$AboutEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appVersion = null,
    Object? platform = null,
  }) {
    return _then(_value.copyWith(
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AboutEntityImplCopyWith<$Res>
    implements $AboutEntityCopyWith<$Res> {
  factory _$$AboutEntityImplCopyWith(
          _$AboutEntityImpl value, $Res Function(_$AboutEntityImpl) then) =
      __$$AboutEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appVersion, String platform});
}

/// @nodoc
class __$$AboutEntityImplCopyWithImpl<$Res>
    extends _$AboutEntityCopyWithImpl<$Res, _$AboutEntityImpl>
    implements _$$AboutEntityImplCopyWith<$Res> {
  __$$AboutEntityImplCopyWithImpl(
      _$AboutEntityImpl _value, $Res Function(_$AboutEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appVersion = null,
    Object? platform = null,
  }) {
    return _then(_$AboutEntityImpl(
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AboutEntityImpl extends _AboutEntity {
  const _$AboutEntityImpl({required this.appVersion, required this.platform})
      : super._();

  factory _$AboutEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AboutEntityImplFromJson(json);

  @override
  final String appVersion;
  @override
  final String platform;

  @override
  String toString() {
    return 'AboutEntity(appVersion: $appVersion, platform: $platform)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AboutEntityImpl &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appVersion, platform);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AboutEntityImplCopyWith<_$AboutEntityImpl> get copyWith =>
      __$$AboutEntityImplCopyWithImpl<_$AboutEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AboutEntityImplToJson(
      this,
    );
  }
}

abstract class _AboutEntity extends AboutEntity {
  const factory _AboutEntity(
      {required final String appVersion,
      required final String platform}) = _$AboutEntityImpl;
  const _AboutEntity._() : super._();

  factory _AboutEntity.fromJson(Map<String, dynamic> json) =
      _$AboutEntityImpl.fromJson;

  @override
  String get appVersion;
  @override
  String get platform;
  @override
  @JsonKey(ignore: true)
  _$$AboutEntityImplCopyWith<_$AboutEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
