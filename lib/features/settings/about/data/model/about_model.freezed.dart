// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'about_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AboutModel _$AboutModelFromJson(Map<String, dynamic> json) {
  return _AboutModel.fromJson(json);
}

/// @nodoc
mixin _$AboutModel {
  String get appVersion => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AboutModelCopyWith<AboutModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AboutModelCopyWith<$Res> {
  factory $AboutModelCopyWith(
          AboutModel value, $Res Function(AboutModel) then) =
      _$AboutModelCopyWithImpl<$Res, AboutModel>;
  @useResult
  $Res call({String appVersion, String platform});
}

/// @nodoc
class _$AboutModelCopyWithImpl<$Res, $Val extends AboutModel>
    implements $AboutModelCopyWith<$Res> {
  _$AboutModelCopyWithImpl(this._value, this._then);

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
abstract class _$$AboutModelImplCopyWith<$Res>
    implements $AboutModelCopyWith<$Res> {
  factory _$$AboutModelImplCopyWith(
          _$AboutModelImpl value, $Res Function(_$AboutModelImpl) then) =
      __$$AboutModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appVersion, String platform});
}

/// @nodoc
class __$$AboutModelImplCopyWithImpl<$Res>
    extends _$AboutModelCopyWithImpl<$Res, _$AboutModelImpl>
    implements _$$AboutModelImplCopyWith<$Res> {
  __$$AboutModelImplCopyWithImpl(
      _$AboutModelImpl _value, $Res Function(_$AboutModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appVersion = null,
    Object? platform = null,
  }) {
    return _then(_$AboutModelImpl(
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
class _$AboutModelImpl extends _AboutModel {
  const _$AboutModelImpl({required this.appVersion, required this.platform})
      : super._();

  factory _$AboutModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AboutModelImplFromJson(json);

  @override
  final String appVersion;
  @override
  final String platform;

  @override
  String toString() {
    return 'AboutModel(appVersion: $appVersion, platform: $platform)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AboutModelImpl &&
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
  _$$AboutModelImplCopyWith<_$AboutModelImpl> get copyWith =>
      __$$AboutModelImplCopyWithImpl<_$AboutModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AboutModelImplToJson(
      this,
    );
  }
}

abstract class _AboutModel extends AboutModel {
  const factory _AboutModel(
      {required final String appVersion,
      required final String platform}) = _$AboutModelImpl;
  const _AboutModel._() : super._();

  factory _AboutModel.fromJson(Map<String, dynamic> json) =
      _$AboutModelImpl.fromJson;

  @override
  String get appVersion;
  @override
  String get platform;
  @override
  @JsonKey(ignore: true)
  _$$AboutModelImplCopyWith<_$AboutModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
