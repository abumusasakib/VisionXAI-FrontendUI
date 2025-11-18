import 'dart:developer' as developer;

/// Simple Mapper contract used by the image caption feature.
abstract class Mapper<TFrom, TTo> {
  TTo map(TFrom from);
}

/// A small helper base class that provides a simple exception wrapper.
/// Implementations may call [run] to execute mapping logic and bubble exceptions.
abstract class MapperImpl<TFrom, TTo> implements Mapper<TFrom, TTo> {
  @override
  TTo map(TFrom from) => run(() => performMap(from));

  /// Concrete mappers should implement [performMap] with their mapping logic.
  /// [map] will wrap that call with [run] so exceptions are logged.
  TTo performMap(TFrom from);

  TTo run(TTo Function() fn) {
    try {
      return fn();
    } catch (e, st) {
      try {
        final mapperType = runtimeType;
        developer.log(
          'MapperImpl.run failed in $mapperType: ${e.runtimeType}: $e',
          name: 'MapperImpl',
          error: e,
          stackTrace: st,
        );
      } catch (_) {}
      rethrow;
    }
  }
}
