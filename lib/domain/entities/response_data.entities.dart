class ResponseData<T> {
  bool error;
  int statusCode;
  String message;
  List<T>? data;

  ResponseData({
    required this.error,
    required this.statusCode,
    required this.message,
    this.data,
  });
}
