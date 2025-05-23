
sealed class Response<T> {
  const Response();
}

class Success<T> extends Response<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Response<T> {
  final String message;
  const Error(this.message);
}

extension ResponseX<T> on Response<T> {
  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(String message) onError,
  }) {
    return switch (this) {
      Success(:final data) => onSuccess(data),
      Error(:final message) => onError(message),
    };
  }
}
