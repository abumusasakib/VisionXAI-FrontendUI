// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attention_grid.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttentionGrid _$AttentionGridFromJson(Map<String, dynamic> json) {
  return _AttentionGrid.fromJson(json);
}

/// @nodoc
mixin _$AttentionGrid {
  int get rows => throw _privateConstructorUsedError;
  int get cols => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttentionGridCopyWith<AttentionGrid> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttentionGridCopyWith<$Res> {
  factory $AttentionGridCopyWith(
          AttentionGrid value, $Res Function(AttentionGrid) then) =
      _$AttentionGridCopyWithImpl<$Res, AttentionGrid>;
  @useResult
  $Res call({int rows, int cols});
}

/// @nodoc
class _$AttentionGridCopyWithImpl<$Res, $Val extends AttentionGrid>
    implements $AttentionGridCopyWith<$Res> {
  _$AttentionGridCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? cols = null,
  }) {
    return _then(_value.copyWith(
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as int,
      cols: null == cols
          ? _value.cols
          : cols // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttentionGridImplCopyWith<$Res>
    implements $AttentionGridCopyWith<$Res> {
  factory _$$AttentionGridImplCopyWith(
          _$AttentionGridImpl value, $Res Function(_$AttentionGridImpl) then) =
      __$$AttentionGridImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int rows, int cols});
}

/// @nodoc
class __$$AttentionGridImplCopyWithImpl<$Res>
    extends _$AttentionGridCopyWithImpl<$Res, _$AttentionGridImpl>
    implements _$$AttentionGridImplCopyWith<$Res> {
  __$$AttentionGridImplCopyWithImpl(
      _$AttentionGridImpl _value, $Res Function(_$AttentionGridImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rows = null,
    Object? cols = null,
  }) {
    return _then(_$AttentionGridImpl(
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as int,
      cols: null == cols
          ? _value.cols
          : cols // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttentionGridImpl extends _AttentionGrid {
  const _$AttentionGridImpl({required this.rows, required this.cols})
      : super._();

  factory _$AttentionGridImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttentionGridImplFromJson(json);

  @override
  final int rows;
  @override
  final int cols;

  @override
  String toString() {
    return 'AttentionGrid(rows: $rows, cols: $cols)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttentionGridImpl &&
            (identical(other.rows, rows) || other.rows == rows) &&
            (identical(other.cols, cols) || other.cols == cols));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rows, cols);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttentionGridImplCopyWith<_$AttentionGridImpl> get copyWith =>
      __$$AttentionGridImplCopyWithImpl<_$AttentionGridImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttentionGridImplToJson(
      this,
    );
  }
}

abstract class _AttentionGrid extends AttentionGrid {
  const factory _AttentionGrid(
      {required final int rows, required final int cols}) = _$AttentionGridImpl;
  const _AttentionGrid._() : super._();

  factory _AttentionGrid.fromJson(Map<String, dynamic> json) =
      _$AttentionGridImpl.fromJson;

  @override
  int get rows;
  @override
  int get cols;
  @override
  @JsonKey(ignore: true)
  _$$AttentionGridImplCopyWith<_$AttentionGridImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
