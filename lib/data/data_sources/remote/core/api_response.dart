part 'failure_response.dart';

sealed class ApiResponse<T> {
  const ApiResponse();

  bool get isSucceed;

  T? get succeedData;

  String? get errorMessage;
}

final class SucceedResponse<T> implements ApiResponse<T> {
  final T? data;

  const SucceedResponse(this.data);

  @override
  bool get isSucceed => true;

  @override
  T? get succeedData => data;

  @override
  String? get errorMessage => null;
}
