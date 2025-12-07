part of 'sample_feature_cubit.dart';


@freezed
class SampleFeatureState with _$SampleFeatureState {
  const factory SampleFeatureState.initial() = _Initial;
  const factory SampleFeatureState.loading() = _Loading;
  const factory SampleFeatureState.loaded(SampleFeatureEntity entity) = _Loaded;
  const factory SampleFeatureState.failure(Object error) = _Failure;
  const factory SampleFeatureState.unKnown() = _Unknown;
}
