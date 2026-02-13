// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attention_grid.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttentionGrid {

 int get rows; int get cols;
/// Create a copy of AttentionGrid
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttentionGridCopyWith<AttentionGrid> get copyWith => _$AttentionGridCopyWithImpl<AttentionGrid>(this as AttentionGrid, _$identity);

  /// Serializes this AttentionGrid to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttentionGrid&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rows,cols);

@override
String toString() {
  return 'AttentionGrid(rows: $rows, cols: $cols)';
}


}

/// @nodoc
abstract mixin class $AttentionGridCopyWith<$Res>  {
  factory $AttentionGridCopyWith(AttentionGrid value, $Res Function(AttentionGrid) _then) = _$AttentionGridCopyWithImpl;
@useResult
$Res call({
 int rows, int cols
});




}
/// @nodoc
class _$AttentionGridCopyWithImpl<$Res>
    implements $AttentionGridCopyWith<$Res> {
  _$AttentionGridCopyWithImpl(this._self, this._then);

  final AttentionGrid _self;
  final $Res Function(AttentionGrid) _then;

/// Create a copy of AttentionGrid
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rows = null,Object? cols = null,}) {
  return _then(_self.copyWith(
rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AttentionGrid].
extension AttentionGridPatterns on AttentionGrid {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttentionGrid value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttentionGrid() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttentionGrid value)  $default,){
final _that = this;
switch (_that) {
case _AttentionGrid():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttentionGrid value)?  $default,){
final _that = this;
switch (_that) {
case _AttentionGrid() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rows,  int cols)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttentionGrid() when $default != null:
return $default(_that.rows,_that.cols);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rows,  int cols)  $default,) {final _that = this;
switch (_that) {
case _AttentionGrid():
return $default(_that.rows,_that.cols);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rows,  int cols)?  $default,) {final _that = this;
switch (_that) {
case _AttentionGrid() when $default != null:
return $default(_that.rows,_that.cols);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttentionGrid extends AttentionGrid {
  const _AttentionGrid({required this.rows, required this.cols}): super._();
  factory _AttentionGrid.fromJson(Map<String, dynamic> json) => _$AttentionGridFromJson(json);

@override final  int rows;
@override final  int cols;

/// Create a copy of AttentionGrid
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttentionGridCopyWith<_AttentionGrid> get copyWith => __$AttentionGridCopyWithImpl<_AttentionGrid>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttentionGridToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttentionGrid&&(identical(other.rows, rows) || other.rows == rows)&&(identical(other.cols, cols) || other.cols == cols));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rows,cols);

@override
String toString() {
  return 'AttentionGrid(rows: $rows, cols: $cols)';
}


}

/// @nodoc
abstract mixin class _$AttentionGridCopyWith<$Res> implements $AttentionGridCopyWith<$Res> {
  factory _$AttentionGridCopyWith(_AttentionGrid value, $Res Function(_AttentionGrid) _then) = __$AttentionGridCopyWithImpl;
@override @useResult
$Res call({
 int rows, int cols
});




}
/// @nodoc
class __$AttentionGridCopyWithImpl<$Res>
    implements _$AttentionGridCopyWith<$Res> {
  __$AttentionGridCopyWithImpl(this._self, this._then);

  final _AttentionGrid _self;
  final $Res Function(_AttentionGrid) _then;

/// Create a copy of AttentionGrid
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rows = null,Object? cols = null,}) {
  return _then(_AttentionGrid(
rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as int,cols: null == cols ? _self.cols : cols // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
