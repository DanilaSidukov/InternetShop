
abstract class Response<T> {

  const Response._();

  factory Response.success(T data) = Success<T>._;

  factory Response.error(String message) = Error<T>._;
}

class Success<T> extends Response<T> {

  final T data;

  const Success._(this.data): super._();
}

class Error<T> extends Response<T> {
  final String message;

  const Error._(this.message) : super._();
}
