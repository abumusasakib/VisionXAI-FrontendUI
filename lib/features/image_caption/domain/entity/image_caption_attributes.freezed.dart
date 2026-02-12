// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_caption_attributes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageCaptionAttributes _$ImageCaptionAttributesFromJson(
    Map<String, dynamic> json) {
  return _ImageCaptionAttributes.fromJson(json);
}

/// @nodoc
mixin _$ImageCaptionAttributes {
  String get caption => throw _privateConstructorUsedError;
  String? get filename => throw _privateConstructorUsedError;
  List<int>? get tokenIds => throw _privateConstructorUsedError;
  List<String>? get tokens => throw _privateConstructorUsedError;
  List<double>? get tokenScores => throw _privateConstructorUsedError;
  String? get attentionImage => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? get attentionImageBytes => throw _privateConstructorUsedError;
  List<double>? get attentionMeans => throw _privateConstructorUsedError;
  List<String>? get attentionColors => throw _privateConstructorUsedError;
  Map<String, String>? get attentionColorMap =>
      throw _privateConstructorUsedError;
  List<List<TopKItem>>? get attentionTopk => throw _privateConstructorUsedError;
  @JsonKey(name: 'attention_topk_items')
  List<List<TopKItem>>? get attentionTopkItems =>
      throw _privateConstructorUsedError;
  AttentionGrid? get attentionGrid => throw _privateConstructorUsedError;
  Map<String, dynamic>? get attentionShape =>
      throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  AttentionGrid? get attentionGridTyped => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<int>? get attentionGridList => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, int>? get attentionGridMap => throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageCaptionAttributesCopyWith<ImageCaptionAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageCaptionAttributesCopyWith<$Res> {
  factory $ImageCaptionAttributesCopyWith(ImageCaptionAttributes value,
          $Res Function(ImageCaptionAttributes) then) =
      _$ImageCaptionAttributesCopyWithImpl<$Res, ImageCaptionAttributes>;
  @useResult
  $Res call(
      {String caption,
      String? filename,
      List<int>? tokenIds,
      List<String>? tokens,
      List<double>? tokenScores,
      String? attentionImage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Uint8List? attentionImageBytes,
      List<double>? attentionMeans,
      List<String>? attentionColors,
      Map<String, String>? attentionColorMap,
      List<List<TopKItem>>? attentionTopk,
      @JsonKey(name: 'attention_topk_items')
      List<List<TopKItem>>? attentionTopkItems,
      AttentionGrid? attentionGrid,
      Map<String, dynamic>? attentionShape,
      @JsonKey(includeFromJson: false, includeToJson: false)
      AttentionGrid? attentionGridTyped,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<int>? attentionGridList,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<String, int>? attentionGridMap,
      double? confidence});

  $AttentionGridCopyWith<$Res>? get attentionGrid;
  $AttentionGridCopyWith<$Res>? get attentionGridTyped;
}

/// @nodoc
class _$ImageCaptionAttributesCopyWithImpl<$Res,
        $Val extends ImageCaptionAttributes>
    implements $ImageCaptionAttributesCopyWith<$Res> {
  _$ImageCaptionAttributesCopyWithImpl(this._value, this._then);

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
    Object? attentionTopkItems = freezed,
    Object? attentionGrid = freezed,
    Object? attentionShape = freezed,
    Object? attentionGridTyped = freezed,
    Object? attentionGridList = freezed,
    Object? attentionGridMap = freezed,
    Object? confidence = freezed,
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
              as Uint8List?,
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
      attentionTopkItems: freezed == attentionTopkItems
          ? _value.attentionTopkItems
          : attentionTopkItems // ignore: cast_nullable_to_non_nullable
              as List<List<TopKItem>>?,
      attentionGrid: freezed == attentionGrid
          ? _value.attentionGrid
          : attentionGrid // ignore: cast_nullable_to_non_nullable
              as AttentionGrid?,
      attentionShape: freezed == attentionShape
          ? _value.attentionShape
          : attentionShape // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      attentionGridTyped: freezed == attentionGridTyped
          ? _value.attentionGridTyped
          : attentionGridTyped // ignore: cast_nullable_to_non_nullable
              as AttentionGrid?,
      attentionGridList: freezed == attentionGridList
          ? _value.attentionGridList
          : attentionGridList // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      attentionGridMap: freezed == attentionGridMap
          ? _value.attentionGridMap
          : attentionGridMap // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
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

  @override
  @pragma('vm:prefer-inline')
  $AttentionGridCopyWith<$Res>? get attentionGridTyped {
    if (_value.attentionGridTyped == null) {
      return null;
    }

    return $AttentionGridCopyWith<$Res>(_value.attentionGridTyped!, (value) {
      return _then(_value.copyWith(attentionGridTyped: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ImageCaptionAttributesImplCopyWith<$Res>
    implements $ImageCaptionAttributesCopyWith<$Res> {
  factory _$$ImageCaptionAttributesImplCopyWith(
          _$ImageCaptionAttributesImpl value,
          $Res Function(_$ImageCaptionAttributesImpl) then) =
      __$$ImageCaptionAttributesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String caption,
      String? filename,
      List<int>? tokenIds,
      List<String>? tokens,
      List<double>? tokenScores,
      String? attentionImage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Uint8List? attentionImageBytes,
      List<double>? attentionMeans,
      List<String>? attentionColors,
      Map<String, String>? attentionColorMap,
      List<List<TopKItem>>? attentionTopk,
      @JsonKey(name: 'attention_topk_items')
      List<List<TopKItem>>? attentionTopkItems,
      AttentionGrid? attentionGrid,
      Map<String, dynamic>? attentionShape,
      @JsonKey(includeFromJson: false, includeToJson: false)
      AttentionGrid? attentionGridTyped,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<int>? attentionGridList,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<String, int>? attentionGridMap,
      double? confidence});

  @override
  $AttentionGridCopyWith<$Res>? get attentionGrid;
  @override
  $AttentionGridCopyWith<$Res>? get attentionGridTyped;
}

/// @nodoc
class __$$ImageCaptionAttributesImplCopyWithImpl<$Res>
    extends _$ImageCaptionAttributesCopyWithImpl<$Res,
        _$ImageCaptionAttributesImpl>
    implements _$$ImageCaptionAttributesImplCopyWith<$Res> {
  __$$ImageCaptionAttributesImplCopyWithImpl(
      _$ImageCaptionAttributesImpl _value,
      $Res Function(_$ImageCaptionAttributesImpl) _then)
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
    Object? attentionTopkItems = freezed,
    Object? attentionGrid = freezed,
    Object? attentionShape = freezed,
    Object? attentionGridTyped = freezed,
    Object? attentionGridList = freezed,
    Object? attentionGridMap = freezed,
    Object? confidence = freezed,
  }) {
    return _then(_$ImageCaptionAttributesImpl(
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
              as Uint8List?,
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
      attentionTopkItems: freezed == attentionTopkItems
          ? _value._attentionTopkItems
          : attentionTopkItems // ignore: cast_nullable_to_non_nullable
              as List<List<TopKItem>>?,
      attentionGrid: freezed == attentionGrid
          ? _value.attentionGrid
          : attentionGrid // ignore: cast_nullable_to_non_nullable
              as AttentionGrid?,
      attentionShape: freezed == attentionShape
          ? _value._attentionShape
          : attentionShape // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      attentionGridTyped: freezed == attentionGridTyped
          ? _value.attentionGridTyped
          : attentionGridTyped // ignore: cast_nullable_to_non_nullable
              as AttentionGrid?,
      attentionGridList: freezed == attentionGridList
          ? _value._attentionGridList
          : attentionGridList // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      attentionGridMap: freezed == attentionGridMap
          ? _value._attentionGridMap
          : attentionGridMap // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageCaptionAttributesImpl implements _ImageCaptionAttributes {
  const _$ImageCaptionAttributesImpl(
      {required this.caption,
      this.filename,
      final List<int>? tokenIds,
      final List<String>? tokens,
      final List<double>? tokenScores,
      this.attentionImage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.attentionImageBytes,
      final List<double>? attentionMeans,
      final List<String>? attentionColors,
      final Map<String, String>? attentionColorMap,
      final List<List<TopKItem>>? attentionTopk,
      @JsonKey(name: 'attention_topk_items')
      final List<List<TopKItem>>? attentionTopkItems,
      this.attentionGrid,
      final Map<String, dynamic>? attentionShape,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.attentionGridTyped,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<int>? attentionGridList,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Map<String, int>? attentionGridMap,
      this.confidence})
      : _tokenIds = tokenIds,
        _tokens = tokens,
        _tokenScores = tokenScores,
        _attentionMeans = attentionMeans,
        _attentionColors = attentionColors,
        _attentionColorMap = attentionColorMap,
        _attentionTopk = attentionTopk,
        _attentionTopkItems = attentionTopkItems,
        _attentionShape = attentionShape,
        _attentionGridList = attentionGridList,
        _attentionGridMap = attentionGridMap;

  factory _$ImageCaptionAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageCaptionAttributesImplFromJson(json);

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
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Uint8List? attentionImageBytes;
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

  final List<List<TopKItem>>? _attentionTopkItems;
  @override
  @JsonKey(name: 'attention_topk_items')
  List<List<TopKItem>>? get attentionTopkItems {
    final value = _attentionTopkItems;
    if (value == null) return null;
    if (_attentionTopkItems is EqualUnmodifiableListView)
      return _attentionTopkItems;
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
  @JsonKey(includeFromJson: false, includeToJson: false)
  final AttentionGrid? attentionGridTyped;
  final List<int>? _attentionGridList;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<int>? get attentionGridList {
    final value = _attentionGridList;
    if (value == null) return null;
    if (_attentionGridList is EqualUnmodifiableListView)
      return _attentionGridList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, int>? _attentionGridMap;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, int>? get attentionGridMap {
    final value = _attentionGridMap;
    if (value == null) return null;
    if (_attentionGridMap is EqualUnmodifiableMapView) return _attentionGridMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final double? confidence;

  @override
  String toString() {
    return 'ImageCaptionAttributes(caption: $caption, filename: $filename, tokenIds: $tokenIds, tokens: $tokens, tokenScores: $tokenScores, attentionImage: $attentionImage, attentionImageBytes: $attentionImageBytes, attentionMeans: $attentionMeans, attentionColors: $attentionColors, attentionColorMap: $attentionColorMap, attentionTopk: $attentionTopk, attentionTopkItems: $attentionTopkItems, attentionGrid: $attentionGrid, attentionShape: $attentionShape, attentionGridTyped: $attentionGridTyped, attentionGridList: $attentionGridList, attentionGridMap: $attentionGridMap, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageCaptionAttributesImpl &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            const DeepCollectionEquality().equals(other._tokenIds, _tokenIds) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            const DeepCollectionEquality()
                .equals(other._tokenScores, _tokenScores) &&
            (identical(other.attentionImage, attentionImage) ||
                other.attentionImage == attentionImage) &&
            const DeepCollectionEquality()
                .equals(other.attentionImageBytes, attentionImageBytes) &&
            const DeepCollectionEquality()
                .equals(other._attentionMeans, _attentionMeans) &&
            const DeepCollectionEquality()
                .equals(other._attentionColors, _attentionColors) &&
            const DeepCollectionEquality()
                .equals(other._attentionColorMap, _attentionColorMap) &&
            const DeepCollectionEquality()
                .equals(other._attentionTopk, _attentionTopk) &&
            const DeepCollectionEquality()
                .equals(other._attentionTopkItems, _attentionTopkItems) &&
            (identical(other.attentionGrid, attentionGrid) ||
                other.attentionGrid == attentionGrid) &&
            const DeepCollectionEquality()
                .equals(other._attentionShape, _attentionShape) &&
            (identical(other.attentionGridTyped, attentionGridTyped) ||
                other.attentionGridTyped == attentionGridTyped) &&
            const DeepCollectionEquality()
                .equals(other._attentionGridList, _attentionGridList) &&
            const DeepCollectionEquality()
                .equals(other._attentionGridMap, _attentionGridMap) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
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
      const DeepCollectionEquality().hash(attentionImageBytes),
      const DeepCollectionEquality().hash(_attentionMeans),
      const DeepCollectionEquality().hash(_attentionColors),
      const DeepCollectionEquality().hash(_attentionColorMap),
      const DeepCollectionEquality().hash(_attentionTopk),
      const DeepCollectionEquality().hash(_attentionTopkItems),
      attentionGrid,
      const DeepCollectionEquality().hash(_attentionShape),
      attentionGridTyped,
      const DeepCollectionEquality().hash(_attentionGridList),
      const DeepCollectionEquality().hash(_attentionGridMap),
      confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageCaptionAttributesImplCopyWith<_$ImageCaptionAttributesImpl>
      get copyWith => __$$ImageCaptionAttributesImplCopyWithImpl<
          _$ImageCaptionAttributesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageCaptionAttributesImplToJson(
      this,
    );
  }
}

abstract class _ImageCaptionAttributes implements ImageCaptionAttributes {
  const factory _ImageCaptionAttributes(
      {required final String caption,
      final String? filename,
      final List<int>? tokenIds,
      final List<String>? tokens,
      final List<double>? tokenScores,
      final String? attentionImage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Uint8List? attentionImageBytes,
      final List<double>? attentionMeans,
      final List<String>? attentionColors,
      final Map<String, String>? attentionColorMap,
      final List<List<TopKItem>>? attentionTopk,
      @JsonKey(name: 'attention_topk_items')
      final List<List<TopKItem>>? attentionTopkItems,
      final AttentionGrid? attentionGrid,
      final Map<String, dynamic>? attentionShape,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final AttentionGrid? attentionGridTyped,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<int>? attentionGridList,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Map<String, int>? attentionGridMap,
      final double? confidence}) = _$ImageCaptionAttributesImpl;

  factory _ImageCaptionAttributes.fromJson(Map<String, dynamic> json) =
      _$ImageCaptionAttributesImpl.fromJson;

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
  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? get attentionImageBytes;
  @override
  List<double>? get attentionMeans;
  @override
  List<String>? get attentionColors;
  @override
  Map<String, String>? get attentionColorMap;
  @override
  List<List<TopKItem>>? get attentionTopk;
  @override
  @JsonKey(name: 'attention_topk_items')
  List<List<TopKItem>>? get attentionTopkItems;
  @override
  AttentionGrid? get attentionGrid;
  @override
  Map<String, dynamic>? get attentionShape;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  AttentionGrid? get attentionGridTyped;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<int>? get attentionGridList;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, int>? get attentionGridMap;
  @override
  double? get confidence;
  @override
  @JsonKey(ignore: true)
  _$$ImageCaptionAttributesImplCopyWith<_$ImageCaptionAttributesImpl>
      get copyWith => throw _privateConstructorUsedError;
}
