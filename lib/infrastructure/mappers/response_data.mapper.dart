import 'package:hope_app/domain/domain.dart';

class ResponseMapper<T> {
  static ResponseDataList<T> responseJsonListToEntity<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) =>
      ResponseDataList<T>(
        error: json["error"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<T>.from(json["data"]!.map((x) => fromJson(x))),
      );

  static ResponseDataObject<T> responseJsonToEntity<T>({
    required Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJson,
  }) =>
      ResponseDataObject<T>(
          error: json["error"],
          statusCode: json["statusCode"],
          message: json["message"],
          data: json["data"] == null ? null : fromJson!(json["data"]));
}
