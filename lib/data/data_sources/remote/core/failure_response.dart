part of 'api_response.dart';

sealed class FailureResponse<T> implements ApiResponse<T> {
  final String? message;
  final String? code;
  final Object? details;
  final String? hint;

  const FailureResponse({
    this.message,
    this.code,
    this.details,
    this.hint,
  });

  @override
  String? get errorMessage => message;

  @override
  bool get isSucceed => false;

  @override
  T? get succeedData => null;
}

final class ServerException<T> extends FailureResponse<T> {
  const ServerException({
    super.message,
    super.code,
    super.details,
    super.hint,
  });
}

final class UnknownException<T> extends FailureResponse<T> {
  const UnknownException({super.message});
}

final class NotFoundException<T> extends FailureResponse<T> {
  const NotFoundException({super.message});
}
