/// Simple Mapper contract used by the feature template.
abstract class Mapper<TFrom, TTo> {
  TTo map(TFrom from);
}

/// A small helper base class that provides a simple exception wrapper.
/// Implementations may call [run] to execute mapping logic and bubble exceptions.
abstract class MapperImpl<TFrom, TTo> implements Mapper<TFrom, TTo> {
  @override
  TTo map(TFrom from) => throw UnimplementedError();

  TTo run(TTo Function() fn) {
    try {
      return fn();
    } catch (e) {
      rethrow;
    }
  }
}
