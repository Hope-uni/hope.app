import 'package:hope_app/domain/domain.dart';

class ResponseMapper<T> {
  static ResponseData<T> responseJsonToEntity<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) =>
      ResponseData<T>(
        error: json["error"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<T>.from(json["data"]!.map((x) => fromJson(x))),
      );
}
