// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_caption_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageCaptionResponseDto {

 String get caption; String? get filename; List<int>? get tokenIds; List<String>? get tokens; List<double>? get tokenScores; String? get attentionImage; String? get attentionImageBytes; List<double>? get attentionMeans; List<String>? get attentionColors; Map<String, String>? get attentionColorMap; List<List<TopKItem>>? get attentionTopk; AttentionGrid? get attentionGrid; Map<String, dynamic>? get attentionShape; double? get confidence; String? get id; int? get statusCode;
/// Create a copy of ImageCaptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageCaptionResponseDtoCopyWith<ImageCaptionResponseDto> get copyWith => _$ImageCaptionResponseDtoCopyWithImpl<ImageCaptionResponseDto>(this as ImageCaptionResponseDto, _$identity);

  /// Serializes this ImageCaptionResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageCaptionResponseDto&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.filename, filename) || other.filename == filename)&&const DeepCollectionEquality().equals(other.tokenIds, tokenIds)&&const DeepCollectionEquality().equals(other.tokens, tokens)&&const DeepCollectionEquality().equals(other.tokenScores, tokenScores)&&(identical(other.attentionImage, attentionImage) || other.attentionImage == attentionImage)&&(identical(other.attentionImageBytes, attentionImageBytes) || other.attentionImageBytes == attentionImageBytes)&&const DeepCollectionEquality().equals(other.attentionMeans, attentionMeans)&&const DeepCollectionEquality().equals(other.attentionColors, attentionColors)&&const DeepCollectionEquality().equals(other.attentionColorMap, attentionColorMap)&&const DeepCollectionEquality().equals(other.attentionTopk, attentionTopk)&&(identical(other.attentionGrid, attentionGrid) || other.attentionGrid == attentionGrid)&&const DeepCollectionEquality().equals(other.attentionShape, attentionShape)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.id, id) || other.id == id)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,caption,filename,const DeepCollectionEquality().hash(tokenIds),const DeepCollectionEquality().hash(tokens),const DeepCollectionEquality().hash(tokenScores),attentionImage,attentionImageBytes,const DeepCollectionEquality().hash(attentionMeans),const DeepCollectionEquality().hash(attentionColors),const DeepCollectionEquality().hash(attentionColorMap),const DeepCollectionEquality().hash(attentionTopk),attentionGrid,const DeepCollectionEquality().hash(attentionShape),confidence,id,statusCode);

@override
String toString() {
  return 'ImageCaptionResponseDto(caption: $caption, filename: $filename, tokenIds: $tokenIds, tokens: $tokens, tokenScores: $tokenScores, attentionImage: $attentionImage, attentionImageBytes: $attentionImageBytes, attentionMeans: $attentionMeans, attentionColors: $attentionColors, attentionColorMap: $attentionColorMap, attentionTopk: $attentionTopk, attentionGrid: $attentionGrid, attentionShape: $attentionShape, confidence: $confidence, id: $id, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ImageCaptionResponseDtoCopyWith<$Res>  {
  factory $ImageCaptionResponseDtoCopyWith(ImageCaptionResponseDto value, $Res Function(ImageCaptionResponseDto) _then) = _$ImageCaptionResponseDtoCopyWithImpl;
@useResult
$Res call({
 String caption, String? filename, List<int>? tokenIds, List<String>? tokens, List<double>? tokenScores, String? attentionImage, String? attentionImageBytes, List<double>? attentionMeans, List<String>? attentionColors, Map<String, String>? attentionColorMap, List<List<TopKItem>>? attentionTopk, AttentionGrid? attentionGrid, Map<String, dynamic>? attentionShape, double? confidence, String? id, int? statusCode
});


$AttentionGridCopyWith<$Res>? get attentionGrid;

}
/// @nodoc
class _$ImageCaptionResponseDtoCopyWithImpl<$Res>
    implements $ImageCaptionResponseDtoCopyWith<$Res> {
  _$ImageCaptionResponseDtoCopyWithImpl(this._self, this._then);

  final ImageCaptionResponseDto _self;
  final $Res Function(ImageCaptionResponseDto) _then;

/// Create a copy of ImageCaptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? caption = null,Object? filename = freezed,Object? tokenIds = freezed,Object? tokens = freezed,Object? tokenScores = freezed,Object? attentionImage = freezed,Object? attentionImageBytes = freezed,Object? attentionMeans = freezed,Object? attentionColors = freezed,Object? attentionColorMap = freezed,Object? attentionTopk = freezed,Object? attentionGrid = freezed,Object? attentionShape = freezed,Object? confidence = freezed,Object? id = freezed,Object? statusCode = freezed,}) {
  return _then(_self.copyWith(
caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,tokenIds: freezed == tokenIds ? _self.tokenIds : tokenIds // ignore: cast_nullable_to_non_nullable
as List<int>?,tokens: freezed == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<String>?,tokenScores: freezed == tokenScores ? _self.tokenScores : tokenScores // ignore: cast_nullable_to_non_nullable
as List<double>?,attentionImage: freezed == attentionImage ? _self.attentionImage : attentionImage // ignore: cast_nullable_to_non_nullable
as String?,attentionImageBytes: freezed == attentionImageBytes ? _self.attentionImageBytes : attentionImageBytes // ignore: cast_nullable_to_non_nullable
as String?,attentionMeans: freezed == attentionMeans ? _self.attentionMeans : attentionMeans // ignore: cast_nullable_to_non_nullable
as List<double>?,attentionColors: freezed == attentionColors ? _self.attentionColors : attentionColors // ignore: cast_nullable_to_non_nullable
as List<String>?,attentionColorMap: freezed == attentionColorMap ? _self.attentionColorMap : attentionColorMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,attentionTopk: freezed == attentionTopk ? _self.attentionTopk : attentionTopk // ignore: cast_nullable_to_non_nullable
as List<List<TopKItem>>?,attentionGrid: freezed == attentionGrid ? _self.attentionGrid : attentionGrid // ignore: cast_nullable_to_non_nullable
as AttentionGrid?,attentionShape: freezed == attentionShape ? _self.attentionShape : attentionShape // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ImageCaptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttentionGridCopyWith<$Res>? get attentionGrid {
    if (_self.attentionGrid == null) {
    return null;
  }

  return $AttentionGridCopyWith<$Res>(_self.attentionGrid!, (value) {
    return _then(_self.copyWith(attentionGrid: value));
  });
}
}


/// Adds pattern-matching-related methods to [ImageCaptionResponseDto].
extension ImageCaptionResponseDtoPatterns on ImageCaptionResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageCaptionResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageCaptionResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageCaptionResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _ImageCaptionResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageCaptionResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ImageCaptionResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String caption,  String? filename,  List<int>? tokenIds,  List<String>? tokens,  List<double>? tokenScores,  String? attentionImage,  String? attentionImageBytes,  List<double>? attentionMeans,  List<String>? attentionColors,  Map<String, String>? attentionColorMap,  List<List<TopKItem>>? attentionTopk,  AttentionGrid? attentionGrid,  Map<String, dynamic>? attentionShape,  double? confidence,  String? id,  int? statusCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageCaptionResponseDto() when $default != null:
return $default(_that.caption,_that.filename,_that.tokenIds,_that.tokens,_that.tokenScores,_that.attentionImage,_that.attentionImageBytes,_that.attentionMeans,_that.attentionColors,_that.attentionColorMap,_that.attentionTopk,_that.attentionGrid,_that.attentionShape,_that.confidence,_that.id,_that.statusCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String caption,  String? filename,  List<int>? tokenIds,  List<String>? tokens,  List<double>? tokenScores,  String? attentionImage,  String? attentionImageBytes,  List<double>? attentionMeans,  List<String>? attentionColors,  Map<String, String>? attentionColorMap,  List<List<TopKItem>>? attentionTopk,  AttentionGrid? attentionGrid,  Map<String, dynamic>? attentionShape,  double? confidence,  String? id,  int? statusCode)  $default,) {final _that = this;
switch (_that) {
case _ImageCaptionResponseDto():
return $default(_that.caption,_that.filename,_that.tokenIds,_that.tokens,_that.tokenScores,_that.attentionImage,_that.attentionImageBytes,_that.attentionMeans,_that.attentionColors,_that.attentionColorMap,_that.attentionTopk,_that.attentionGrid,_that.attentionShape,_that.confidence,_that.id,_that.statusCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String caption,  String? filename,  List<int>? tokenIds,  List<String>? tokens,  List<double>? tokenScores,  String? attentionImage,  String? attentionImageBytes,  List<double>? attentionMeans,  List<String>? attentionColors,  Map<String, String>? attentionColorMap,  List<List<TopKItem>>? attentionTopk,  AttentionGrid? attentionGrid,  Map<String, dynamic>? attentionShape,  double? confidence,  String? id,  int? statusCode)?  $default,) {final _that = this;
switch (_that) {
case _ImageCaptionResponseDto() when $default != null:
return $default(_that.caption,_that.filename,_that.tokenIds,_that.tokens,_that.tokenScores,_that.attentionImage,_that.attentionImageBytes,_that.attentionMeans,_that.attentionColors,_that.attentionColorMap,_that.attentionTopk,_that.attentionGrid,_that.attentionShape,_that.confidence,_that.id,_that.statusCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageCaptionResponseDto extends ImageCaptionResponseDto {
  const _ImageCaptionResponseDto({required this.caption, this.filename, final  List<int>? tokenIds, final  List<String>? tokens, final  List<double>? tokenScores, this.attentionImage, this.attentionImageBytes, final  List<double>? attentionMeans, final  List<String>? attentionColors, final  Map<String, String>? attentionColorMap, final  List<List<TopKItem>>? attentionTopk, this.attentionGrid, final  Map<String, dynamic>? attentionShape, this.confidence, this.id, this.statusCode}): _tokenIds = tokenIds,_tokens = tokens,_tokenScores = tokenScores,_attentionMeans = attentionMeans,_attentionColors = attentionColors,_attentionColorMap = attentionColorMap,_attentionTopk = attentionTopk,_attentionShape = attentionShape,super._();
  factory _ImageCaptionResponseDto.fromJson(Map<String, dynamic> json) => _$ImageCaptionResponseDtoFromJson(json);

@override final  String caption;
@override final  String? filename;
 final  List<int>? _tokenIds;
@override List<int>? get tokenIds {
  final value = _tokenIds;
  if (value == null) return null;
  if (_tokenIds is EqualUnmodifiableListView) return _tokenIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _tokens;
@override List<String>? get tokens {
  final value = _tokens;
  if (value == null) return null;
  if (_tokens is EqualUnmodifiableListView) return _tokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<double>? _tokenScores;
@override List<double>? get tokenScores {
  final value = _tokenScores;
  if (value == null) return null;
  if (_tokenScores is EqualUnmodifiableListView) return _tokenScores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? attentionImage;
@override final  String? attentionImageBytes;
 final  List<double>? _attentionMeans;
@override List<double>? get attentionMeans {
  final value = _attentionMeans;
  if (value == null) return null;
  if (_attentionMeans is EqualUnmodifiableListView) return _attentionMeans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _attentionColors;
@override List<String>? get attentionColors {
  final value = _attentionColors;
  if (value == null) return null;
  if (_attentionColors is EqualUnmodifiableListView) return _attentionColors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, String>? _attentionColorMap;
@override Map<String, String>? get attentionColorMap {
  final value = _attentionColorMap;
  if (value == null) return null;
  if (_attentionColorMap is EqualUnmodifiableMapView) return _attentionColorMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<List<TopKItem>>? _attentionTopk;
@override List<List<TopKItem>>? get attentionTopk {
  final value = _attentionTopk;
  if (value == null) return null;
  if (_attentionTopk is EqualUnmodifiableListView) return _attentionTopk;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  AttentionGrid? attentionGrid;
 final  Map<String, dynamic>? _attentionShape;
@override Map<String, dynamic>? get attentionShape {
  final value = _attentionShape;
  if (value == null) return null;
  if (_attentionShape is EqualUnmodifiableMapView) return _attentionShape;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  double? confidence;
@override final  String? id;
@override final  int? statusCode;

/// Create a copy of ImageCaptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageCaptionResponseDtoCopyWith<_ImageCaptionResponseDto> get copyWith => __$ImageCaptionResponseDtoCopyWithImpl<_ImageCaptionResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageCaptionResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageCaptionResponseDto&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.filename, filename) || other.filename == filename)&&const DeepCollectionEquality().equals(other._tokenIds, _tokenIds)&&const DeepCollectionEquality().equals(other._tokens, _tokens)&&const DeepCollectionEquality().equals(other._tokenScores, _tokenScores)&&(identical(other.attentionImage, attentionImage) || other.attentionImage == attentionImage)&&(identical(other.attentionImageBytes, attentionImageBytes) || other.attentionImageBytes == attentionImageBytes)&&const DeepCollectionEquality().equals(other._attentionMeans, _attentionMeans)&&const DeepCollectionEquality().equals(other._attentionColors, _attentionColors)&&const DeepCollectionEquality().equals(other._attentionColorMap, _attentionColorMap)&&const DeepCollectionEquality().equals(other._attentionTopk, _attentionTopk)&&(identical(other.attentionGrid, attentionGrid) || other.attentionGrid == attentionGrid)&&const DeepCollectionEquality().equals(other._attentionShape, _attentionShape)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.id, id) || other.id == id)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,caption,filename,const DeepCollectionEquality().hash(_tokenIds),const DeepCollectionEquality().hash(_tokens),const DeepCollectionEquality().hash(_tokenScores),attentionImage,attentionImageBytes,const DeepCollectionEquality().hash(_attentionMeans),const DeepCollectionEquality().hash(_attentionColors),const DeepCollectionEquality().hash(_attentionColorMap),const DeepCollectionEquality().hash(_attentionTopk),attentionGrid,const DeepCollectionEquality().hash(_attentionShape),confidence,id,statusCode);

@override
String toString() {
  return 'ImageCaptionResponseDto(caption: $caption, filename: $filename, tokenIds: $tokenIds, tokens: $tokens, tokenScores: $tokenScores, attentionImage: $attentionImage, attentionImageBytes: $attentionImageBytes, attentionMeans: $attentionMeans, attentionColors: $attentionColors, attentionColorMap: $attentionColorMap, attentionTopk: $attentionTopk, attentionGrid: $attentionGrid, attentionShape: $attentionShape, confidence: $confidence, id: $id, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$ImageCaptionResponseDtoCopyWith<$Res> implements $ImageCaptionResponseDtoCopyWith<$Res> {
  factory _$ImageCaptionResponseDtoCopyWith(_ImageCaptionResponseDto value, $Res Function(_ImageCaptionResponseDto) _then) = __$ImageCaptionResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String caption, String? filename, List<int>? tokenIds, List<String>? tokens, List<double>? tokenScores, String? attentionImage, String? attentionImageBytes, List<double>? attentionMeans, List<String>? attentionColors, Map<String, String>? attentionColorMap, List<List<TopKItem>>? attentionTopk, AttentionGrid? attentionGrid, Map<String, dynamic>? attentionShape, double? confidence, String? id, int? statusCode
});


@override $AttentionGridCopyWith<$Res>? get attentionGrid;

}
/// @nodoc
class __$ImageCaptionResponseDtoCopyWithImpl<$Res>
    implements _$ImageCaptionResponseDtoCopyWith<$Res> {
  __$ImageCaptionResponseDtoCopyWithImpl(this._self, this._then);

  final _ImageCaptionResponseDto _self;
  final $Res Function(_ImageCaptionResponseDto) _then;

/// Create a copy of ImageCaptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? caption = null,Object? filename = freezed,Object? tokenIds = freezed,Object? tokens = freezed,Object? tokenScores = freezed,Object? attentionImage = freezed,Object? attentionImageBytes = freezed,Object? attentionMeans = freezed,Object? attentionColors = freezed,Object? attentionColorMap = freezed,Object? attentionTopk = freezed,Object? attentionGrid = freezed,Object? attentionShape = freezed,Object? confidence = freezed,Object? id = freezed,Object? statusCode = freezed,}) {
  return _then(_ImageCaptionResponseDto(
caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,tokenIds: freezed == tokenIds ? _self._tokenIds : tokenIds // ignore: cast_nullable_to_non_nullable
as List<int>?,tokens: freezed == tokens ? _self._tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<String>?,tokenScores: freezed == tokenScores ? _self._tokenScores : tokenScores // ignore: cast_nullable_to_non_nullable
as List<double>?,attentionImage: freezed == attentionImage ? _self.attentionImage : attentionImage // ignore: cast_nullable_to_non_nullable
as String?,attentionImageBytes: freezed == attentionImageBytes ? _self.attentionImageBytes : attentionImageBytes // ignore: cast_nullable_to_non_nullable
as String?,attentionMeans: freezed == attentionMeans ? _self._attentionMeans : attentionMeans // ignore: cast_nullable_to_non_nullable
as List<double>?,attentionColors: freezed == attentionColors ? _self._attentionColors : attentionColors // ignore: cast_nullable_to_non_nullable
as List<String>?,attentionColorMap: freezed == attentionColorMap ? _self._attentionColorMap : attentionColorMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,attentionTopk: freezed == attentionTopk ? _self._attentionTopk : attentionTopk // ignore: cast_nullable_to_non_nullable
as List<List<TopKItem>>?,attentionGrid: freezed == attentionGrid ? _self.attentionGrid : attentionGrid // ignore: cast_nullable_to_non_nullable
as AttentionGrid?,attentionShape: freezed == attentionShape ? _self._attentionShape : attentionShape // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,confidence: freezed == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ImageCaptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttentionGridCopyWith<$Res>? get attentionGrid {
    if (_self.attentionGrid == null) {
    return null;
  }

  return $AttentionGridCopyWith<$Res>(_self.attentionGrid!, (value) {
    return _then(_self.copyWith(attentionGrid: value));
  });
}
}

// dart format on
