// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topk_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TopKItem _$TopKItemFromJson(Map<String, dynamic> json) {
  return _TopKItem.fromJson(json);
}

/// @nodoc
mixin _$TopKItem {
  int get row => throw _privateConstructorUsedError;
  int get col => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopKItemCopyWith<TopKItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopKItemCopyWith<$Res> {
  factory $TopKItemCopyWith(TopKItem value, $Res Function(TopKItem) then) =
      _$TopKItemCopyWithImpl<$Res, TopKItem>;
  @useResult
  $Res call({int row, int col, double score});
}

/// @nodoc
class _$TopKItemCopyWithImpl<$Res, $Val extends TopKItem>
    implements $TopKItemCopyWith<$Res> {
  _$TopKItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? row = null,
    Object? col = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      row: null == row
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int,
      col: null == col
          ? _value.col
          : col // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopKItemImplCopyWith<$Res>
    implements $TopKItemCopyWith<$Res> {
  factory _$$TopKItemImplCopyWith(
          _$TopKItemImpl value, $Res Function(_$TopKItemImpl) then) =
      __$$TopKItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int row, int col, double score});
}

/// @nodoc
class __$$TopKItemImplCopyWithImpl<$Res>
    extends _$TopKItemCopyWithImpl<$Res, _$TopKItemImpl>
    implements _$$TopKItemImplCopyWith<$Res> {
  __$$TopKItemImplCopyWithImpl(
      _$TopKItemImpl _value, $Res Function(_$TopKItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? row = null,
    Object? col = null,
    Object? score = null,
  }) {
    return _then(_$TopKItemImpl(
      row: null == row
          ? _value.row
          : row // ignore: cast_nullable_to_non_nullable
              as int,
      col: null == col
          ? _value.col
          : col // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopKItemImpl extends _TopKItem {
  const _$TopKItemImpl(
      {required this.row, required this.col, required this.score})
      : super._();

  factory _$TopKItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopKItemImplFromJson(json);

  @override
  final int row;
  @override
  final int col;
  @override
  final double score;

  @override
  String toString() {
    return 'TopKItem(row: $row, col: $col, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopKItemImpl &&
            (identical(other.row, row) || other.row == row) &&
            (identical(other.col, col) || other.col == col) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, row, col, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopKItemImplCopyWith<_$TopKItemImpl> get copyWith =>
      __$$TopKItemImplCopyWithImpl<_$TopKItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopKItemImplToJson(
      this,
    );
  }
}

abstract class _TopKItem extends TopKItem {
  const factory _TopKItem(
      {required final int row,
      required final int col,
      required final double score}) = _$TopKItemImpl;
  const _TopKItem._() : super._();

  factory _TopKItem.fromJson(Map<String, dynamic> json) =
      _$TopKItemImpl.fromJson;

  @override
  int get row;
  @override
  int get col;
  @override
  double get score;
  @override
  @JsonKey(ignore: true)
  _$$TopKItemImplCopyWith<_$TopKItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
