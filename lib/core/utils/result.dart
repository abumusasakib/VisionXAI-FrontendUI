/// Simple Result wrapper used for returning either a value or an error message.
class Result<T> {
  final T? value;
  final String? errorMessage;

  const Result._({this.value, this.errorMessage});

  bool get isSuccess => errorMessage == null;

  factory Result.success(T value) => Result._(value: value);

  factory Result.failure(String message) => Result._(errorMessage: message);
}
