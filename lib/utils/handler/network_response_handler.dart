class NetworkResponseHandler<T> {
  final bool isSuccess;
  final T? data;
  final String? errorMessage;

  NetworkResponseHandler({
    required this.isSuccess,
    this.data,
    this.errorMessage,
  });
}