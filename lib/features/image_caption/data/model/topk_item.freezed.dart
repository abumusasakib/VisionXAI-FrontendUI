// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topk_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopKItem {

 int get row; int get col; double get score;
/// Create a copy of TopKItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopKItemCopyWith<TopKItem> get copyWith => _$TopKItemCopyWithImpl<TopKItem>(this as TopKItem, _$identity);

  /// Serializes this TopKItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopKItem&&(identical(other.row, row) || other.row == row)&&(identical(other.col, col) || other.col == col)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,row,col,score);

@override
String toString() {
  return 'TopKItem(row: $row, col: $col, score: $score)';
}


}

/// @nodoc
abstract mixin class $TopKItemCopyWith<$Res>  {
  factory $TopKItemCopyWith(TopKItem value, $Res Function(TopKItem) _then) = _$TopKItemCopyWithImpl;
@useResult
$Res call({
 int row, int col, double score
});




}
/// @nodoc
class _$TopKItemCopyWithImpl<$Res>
    implements $TopKItemCopyWith<$Res> {
  _$TopKItemCopyWithImpl(this._self, this._then);

  final TopKItem _self;
  final $Res Function(TopKItem) _then;

/// Create a copy of TopKItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? row = null,Object? col = null,Object? score = null,}) {
  return _then(_self.copyWith(
row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TopKItem].
extension TopKItemPatterns on TopKItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopKItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopKItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopKItem value)  $default,){
final _that = this;
switch (_that) {
case _TopKItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopKItem value)?  $default,){
final _that = this;
switch (_that) {
case _TopKItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int row,  int col,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopKItem() when $default != null:
return $default(_that.row,_that.col,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int row,  int col,  double score)  $default,) {final _that = this;
switch (_that) {
case _TopKItem():
return $default(_that.row,_that.col,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int row,  int col,  double score)?  $default,) {final _that = this;
switch (_that) {
case _TopKItem() when $default != null:
return $default(_that.row,_that.col,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopKItem extends TopKItem {
  const _TopKItem({required this.row, required this.col, required this.score}): super._();
  factory _TopKItem.fromJson(Map<String, dynamic> json) => _$TopKItemFromJson(json);

@override final  int row;
@override final  int col;
@override final  double score;

/// Create a copy of TopKItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopKItemCopyWith<_TopKItem> get copyWith => __$TopKItemCopyWithImpl<_TopKItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopKItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopKItem&&(identical(other.row, row) || other.row == row)&&(identical(other.col, col) || other.col == col)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,row,col,score);

@override
String toString() {
  return 'TopKItem(row: $row, col: $col, score: $score)';
}


}

/// @nodoc
abstract mixin class _$TopKItemCopyWith<$Res> implements $TopKItemCopyWith<$Res> {
  factory _$TopKItemCopyWith(_TopKItem value, $Res Function(_TopKItem) _then) = __$TopKItemCopyWithImpl;
@override @useResult
$Res call({
 int row, int col, double score
});




}
/// @nodoc
class __$TopKItemCopyWithImpl<$Res>
    implements _$TopKItemCopyWith<$Res> {
  __$TopKItemCopyWithImpl(this._self, this._then);

  final _TopKItem _self;
  final $Res Function(_TopKItem) _then;

/// Create a copy of TopKItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? row = null,Object? col = null,Object? score = null,}) {
  return _then(_TopKItem(
row: null == row ? _self.row : row // ignore: cast_nullable_to_non_nullable
as int,col: null == col ? _self.col : col // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
