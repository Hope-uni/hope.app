class ResponseData {
  bool error;
  int statusCode;
  String message;

  ResponseData({
    required this.error,
    required this.statusCode,
    required this.message,
  });
}

class ResponseDataObject<T> extends ResponseData {
  T? data;

  ResponseDataObject(
      {required super.error,
      required super.statusCode,
      required super.message,
      this.data});
}

class ResponseDataList<T> extends ResponseData {
  List<T>? data;

  ResponseDataList(
      {required super.error,
      required super.statusCode,
      required super.message,
      this.data});
}
