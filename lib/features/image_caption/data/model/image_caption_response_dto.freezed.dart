// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_caption_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageCaptionResponseDto _$ImageCaptionResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _ImageCaptionResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ImageCaptionResponseDto {
  String get caption => throw _privateConstructorUsedError;
  String? get filename => throw _privateConstructorUsedError;
  List<int>? get tokenIds => throw _privateConstructorUsedError;
  List<String>? get tokens => throw _privateConstructorUsedError;
  List<double>? get tokenScores => throw _privateConstructorUsedError;
  String? get attentionImage => throw _privateConstructorUsedError;
  String? get attentionImageBytes => throw _privateConstructorUsedError;
  List<double>? get attentionMeans => throw _privateConstructorUsedError;
  List<String>? get attentionColors => throw _privateConstructorUsedError;
  Map<String, String>? get attentionColorMap =>
      throw _privateConstructorUsedError;
  List<List<TopKItem>>? get attentionTopk => throw _privateConstructorUsedError;
  AttentionGrid? get attentionGrid => throw _privateConstructorUsedError;
  Map<String, dynamic>? get attentionShape =>
      throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageCaptionResponseDtoCopyWith<ImageCaptionResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageCaptionResponseDtoCopyWith<$Res> {
  factory $ImageCaptionResponseDtoCopyWith(ImageCaptionResponseDto value,
          $Res Function(ImageCaptionResponseDto) then) =
      _$ImageCaptionResponseDtoCopyWithImpl<$Res, ImageCaptionResponseDto>;
  @useResult
  $Res call(
      {String caption,
      String? filename,
      List<int>? tokenIds,
      List<String>? tokens,
      List<double>? tokenScores,
      String? attentionImage,
      String? attentionImageBytes,
      List<double>? attentionMeans,
      List<String>? attentionColors,
      Map<String, String>? attentionColorMap,
      List<List<TopKItem>>? attentionTopk,
      AttentionGrid? attentionGrid,
      Map<String, dynamic>? attentionShape,
      double? confidence,
      String? id,
      int? statusCode});

  $AttentionGridCopyWith<$Res>? get attentionGrid;
}

/// @nodoc
class _$ImageCaptionResponseDtoCopyWithImpl<$Res,
        $Val extends ImageCaptionResponseDto>
    implements $ImageCaptionResponseDtoCopyWith<$Res> {
  _$ImageCaptionResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caption = null,
    Object? filename = freezed,
    Object? tokenIds = freezed,
    Object? tokens = freezed,
    Object? tokenScores = freezed,
    Object? attentionImage = freezed,
    Object? attentionImageBytes = freezed,
    Object? attentionMeans = freezed,
    Object? attentionColors = freezed,
    Object? attentionColorMap = freezed,
    Object? attentionTopk = freezed,
    Object? attentionGrid = freezed,
    Object? attentionShape = freezed,
    Object? confidence = freezed,
    Object? id = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_value.copyWith(
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenIds: freezed == tokenIds
          ? _value.tokenIds
          : tokenIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      tokens: freezed == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tokenScores: freezed == tokenScores
          ? _value.tokenScores
          : tokenScores // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      attentionImage: freezed == attentionImage
          ? _value.attentionImage
          : attentionImage // ignore: cast_nullable_to_non_nullable
              as String?,
      attentionImageBytes: freezed == attentionImageBytes
          ? _value.attentionImageBytes
          : attentionImageBytes // ignore: cast_nullable_to_non_nullable
              as String?,
      attentionMeans: freezed == attentionMeans
          ? _value.attentionMeans
          : attentionMeans // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      attentionColors: freezed == attentionColors
          ? _value.attentionColors
          : attentionColors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      attentionColorMap: freezed == attentionColorMap
          ? _value.attentionColorMap
          : attentionColorMap // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      attentionTopk: freezed == attentionTopk
          ? _value.attentionTopk
          : attentionTopk // ignore: cast_nullable_to_non_nullable
              as List<List<TopKItem>>?,
      attentionGrid: freezed == attentionGrid
          ? _value.attentionGrid
          : attentionGrid // ignore: cast_nullable_to_non_nullable
              as AttentionGrid?,
      attentionShape: freezed == attentionShape
          ? _value.attentionShape
          : attentionShape // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttentionGridCopyWith<$Res>? get attentionGrid {
    if (_value.attentionGrid == null) {
      return null;
    }

    return $AttentionGridCopyWith<$Res>(_value.attentionGrid!, (value) {
      return _then(_value.copyWith(attentionGrid: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImageCaptionResponseDtoImplCopyWith<$Res>
    implements $ImageCaptionResponseDtoCopyWith<$Res> {
  factory _$$ImageCaptionResponseDtoImplCopyWith(
          _$ImageCaptionResponseDtoImpl value,
          $Res Function(_$ImageCaptionResponseDtoImpl) then) =
      __$$ImageCaptionResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String caption,
      String? filename,
      List<int>? tokenIds,
      List<String>? tokens,
      List<double>? tokenScores,
      String? attentionImage,
      String? attentionImageBytes,
      List<double>? attentionMeans,
      List<String>? attentionColors,
      Map<String, String>? attentionColorMap,
      List<List<TopKItem>>? attentionTopk,
      AttentionGrid? attentionGrid,
      Map<String, dynamic>? attentionShape,
      double? confidence,
      String? id,
      int? statusCode});

  @override
  $AttentionGridCopyWith<$Res>? get attentionGrid;
}

/// @nodoc
class __$$ImageCaptionResponseDtoImplCopyWithImpl<$Res>
    extends _$ImageCaptionResponseDtoCopyWithImpl<$Res,
        _$ImageCaptionResponseDtoImpl>
    implements _$$ImageCaptionResponseDtoImplCopyWith<$Res> {
  __$$ImageCaptionResponseDtoImplCopyWithImpl(
      _$ImageCaptionResponseDtoImpl _value,
      $Res Function(_$ImageCaptionResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caption = null,
    Object? filename = freezed,
    Object? tokenIds = freezed,
    Object? tokens = freezed,
    Object? tokenScores = freezed,
    Object? attentionImage = freezed,
    Object? attentionImageBytes = freezed,
    Object? attentionMeans = freezed,
    Object? attentionColors = freezed,
    Object? attentionColorMap = freezed,
    Object? attentionTopk = freezed,
    Object? attentionGrid = freezed,
    Object? attentionShape = freezed,
    Object? confidence = freezed,
    Object? id = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_$ImageCaptionResponseDtoImpl(
      caption: null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenIds: freezed == tokenIds
          ? _value._tokenIds
          : tokenIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      tokens: freezed == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tokenScores: freezed == tokenScores
          ? _value._tokenScores
          : tokenScores // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      attentionImage: freezed == attentionImage
          ? _value.attentionImage
          : attentionImage // ignore: cast_nullable_to_non_nullable
              as String?,
      attentionImageBytes: freezed == attentionImageBytes
          ? _value.attentionImageBytes
          : attentionImageBytes // ignore: cast_nullable_to_non_nullable
              as String?,
      attentionMeans: freezed == attentionMeans
          ? _value._attentionMeans
          : attentionMeans // ignore: cast_nullable_to_non_nullable
              as List<double>?,
      attentionColors: freezed == attentionColors
          ? _value._attentionColors
          : attentionColors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      attentionColorMap: freezed == attentionColorMap
          ? _value._attentionColorMap
          : attentionColorMap // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      attentionTopk: freezed == attentionTopk
          ? _value._attentionTopk
          : attentionTopk // ignore: cast_nullable_to_non_nullable
              as List<List<TopKItem>>?,
      attentionGrid: freezed == attentionGrid
          ? _value.attentionGrid
          : attentionGrid // ignore: cast_nullable_to_non_nullable
              as AttentionGrid?,
      attentionShape: freezed == attentionShape
          ? _value._attentionShape
          : attentionShape // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageCaptionResponseDtoImpl extends _ImageCaptionResponseDto {
  const _$ImageCaptionResponseDtoImpl(
      {required this.caption,
      this.filename,
      final List<int>? tokenIds,
      final List<String>? tokens,
      final List<double>? tokenScores,
      this.attentionImage,
      this.attentionImageBytes,
      final List<double>? attentionMeans,
      final List<String>? attentionColors,
      final Map<String, String>? attentionColorMap,
      final List<List<TopKItem>>? attentionTopk,
      this.attentionGrid,
      final Map<String, dynamic>? attentionShape,
      this.confidence,
      this.id,
      this.statusCode})
      : _tokenIds = tokenIds,
        _tokens = tokens,
        _tokenScores = tokenScores,
        _attentionMeans = attentionMeans,
        _attentionColors = attentionColors,
        _attentionColorMap = attentionColorMap,
        _attentionTopk = attentionTopk,
        _attentionShape = attentionShape,
        super._();

  factory _$ImageCaptionResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageCaptionResponseDtoImplFromJson(json);

  @override
  final String caption;
  @override
  final String? filename;
  final List<int>? _tokenIds;
  @override
  List<int>? get tokenIds {
    final value = _tokenIds;
    if (value == null) return null;
    if (_tokenIds is EqualUnmodifiableListView) return _tokenIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tokens;
  @override
  List<String>? get tokens {
    final value = _tokens;
    if (value == null) return null;
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<double>? _tokenScores;
  @override
  List<double>? get tokenScores {
    final value = _tokenScores;
    if (value == null) return null;
    if (_tokenScores is EqualUnmodifiableListView) return _tokenScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? attentionImage;
  @override
  final String? attentionImageBytes;
  final List<double>? _attentionMeans;
  @override
  List<double>? get attentionMeans {
    final value = _attentionMeans;
    if (value == null) return null;
    if (_attentionMeans is EqualUnmodifiableListView) return _attentionMeans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _attentionColors;
  @override
  List<String>? get attentionColors {
    final value = _attentionColors;
    if (value == null) return null;
    if (_attentionColors is EqualUnmodifiableListView) return _attentionColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String>? _attentionColorMap;
  @override
  Map<String, String>? get attentionColorMap {
    final value = _attentionColorMap;
    if (value == null) return null;
    if (_attentionColorMap is EqualUnmodifiableMapView)
      return _attentionColorMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<List<TopKItem>>? _attentionTopk;
  @override
  List<List<TopKItem>>? get attentionTopk {
    final value = _attentionTopk;
    if (value == null) return null;
    if (_attentionTopk is EqualUnmodifiableListView) return _attentionTopk;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AttentionGrid? attentionGrid;
  final Map<String, dynamic>? _attentionShape;
  @override
  Map<String, dynamic>? get attentionShape {
    final value = _attentionShape;
    if (value == null) return null;
    if (_attentionShape is EqualUnmodifiableMapView) return _attentionShape;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final double? confidence;
  @override
  final String? id;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'ImageCaptionResponseDto(caption: $caption, filename: $filename, tokenIds: $tokenIds, tokens: $tokens, tokenScores: $tokenScores, attentionImage: $attentionImage, attentionImageBytes: $attentionImageBytes, attentionMeans: $attentionMeans, attentionColors: $attentionColors, attentionColorMap: $attentionColorMap, attentionTopk: $attentionTopk, attentionGrid: $attentionGrid, attentionShape: $attentionShape, confidence: $confidence, id: $id, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageCaptionResponseDtoImpl &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            const DeepCollectionEquality().equals(other._tokenIds, _tokenIds) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            const DeepCollectionEquality()
                .equals(other._tokenScores, _tokenScores) &&
            (identical(other.attentionImage, attentionImage) ||
                other.attentionImage == attentionImage) &&
            (identical(other.attentionImageBytes, attentionImageBytes) ||
                other.attentionImageBytes == attentionImageBytes) &&
            const DeepCollectionEquality()
                .equals(other._attentionMeans, _attentionMeans) &&
            const DeepCollectionEquality()
                .equals(other._attentionColors, _attentionColors) &&
            const DeepCollectionEquality()
                .equals(other._attentionColorMap, _attentionColorMap) &&
            const DeepCollectionEquality()
                .equals(other._attentionTopk, _attentionTopk) &&
            (identical(other.attentionGrid, attentionGrid) ||
                other.attentionGrid == attentionGrid) &&
            const DeepCollectionEquality()
                .equals(other._attentionShape, _attentionShape) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      caption,
      filename,
      const DeepCollectionEquality().hash(_tokenIds),
      const DeepCollectionEquality().hash(_tokens),
      const DeepCollectionEquality().hash(_tokenScores),
      attentionImage,
      attentionImageBytes,
      const DeepCollectionEquality().hash(_attentionMeans),
      const DeepCollectionEquality().hash(_attentionColors),
      const DeepCollectionEquality().hash(_attentionColorMap),
      const DeepCollectionEquality().hash(_attentionTopk),
      attentionGrid,
      const DeepCollectionEquality().hash(_attentionShape),
      confidence,
      id,
      statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageCaptionResponseDtoImplCopyWith<_$ImageCaptionResponseDtoImpl>
      get copyWith => __$$ImageCaptionResponseDtoImplCopyWithImpl<
          _$ImageCaptionResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageCaptionResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _ImageCaptionResponseDto extends ImageCaptionResponseDto {
  const factory _ImageCaptionResponseDto(
      {required final String caption,
      final String? filename,
      final List<int>? tokenIds,
      final List<String>? tokens,
      final List<double>? tokenScores,
      final String? attentionImage,
      final String? attentionImageBytes,
      final List<double>? attentionMeans,
      final List<String>? attentionColors,
      final Map<String, String>? attentionColorMap,
      final List<List<TopKItem>>? attentionTopk,
      final AttentionGrid? attentionGrid,
      final Map<String, dynamic>? attentionShape,
      final double? confidence,
      final String? id,
      final int? statusCode}) = _$ImageCaptionResponseDtoImpl;
  const _ImageCaptionResponseDto._() : super._();

  factory _ImageCaptionResponseDto.fromJson(Map<String, dynamic> json) =
      _$ImageCaptionResponseDtoImpl.fromJson;

  @override
  String get caption;
  @override
  String? get filename;
  @override
  List<int>? get tokenIds;
  @override
  List<String>? get tokens;
  @override
  List<double>? get tokenScores;
  @override
  String? get attentionImage;
  @override
  String? get attentionImageBytes;
  @override
  List<double>? get attentionMeans;
  @override
  List<String>? get attentionColors;
  @override
  Map<String, String>? get attentionColorMap;
  @override
  List<List<TopKItem>>? get attentionTopk;
  @override
  AttentionGrid? get attentionGrid;
  @override
  Map<String, dynamic>? get attentionShape;
  @override
  double? get confidence;
  @override
  String? get id;
  @override
  int? get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$ImageCaptionResponseDtoImplCopyWith<_$ImageCaptionResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
