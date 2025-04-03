class ResponseData {
  bool error;
  int statusCode;
  String message;
  ValidationError? validationErrors;
  Paginate? paginate;

  ResponseData({
    required this.error,
    required this.statusCode,
    required this.message,
    required this.validationErrors,
    this.paginate,
  });
}

class ValidationError {
  final String message;

  ValidationError({required this.message});
}

class Paginate {
  int total;
  int pageCount;
  int page;
  int pageSize;
  int size;

  Paginate({
    required this.total,
    required this.pageCount,
    required this.page,
    required this.pageSize,
    required this.size,
  });
}

class ResponseDataObject<T> extends ResponseData {
  T? data;

  ResponseDataObject({
    required super.error,
    required super.statusCode,
    required super.message,
    this.data,
    required super.validationErrors,
  });
}

class ResponseDataList<T> extends ResponseData {
  List<T>? data;

  ResponseDataList({
    required super.error,
    required super.statusCode,
    required super.message,
    required super.validationErrors,
    this.data,
    required super.paginate,
  });
}
