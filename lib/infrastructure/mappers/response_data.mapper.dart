import 'package:hope_app/domain/domain.dart';

class ResponseMapper<T> {
  static ResponseDataList<T> responseJsonListToEntity<T>({
    required Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJson,
  }) =>
      ResponseDataList<T>(
        error: json["error"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : (json["data"] as List).map((x) => fromJson!(x)).toList(),
        validationErrors: json["validationErrors"] == null
            ? null
            : fromJsonErrors(json["validationErrors"]),
        paginate: json["paginate"] == null
            ? null
            : fromJsonPaginate(json["paginate"]),
      );

  static ResponseDataObject<T> responseJsonToEntity<T>({
    required Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJson,
  }) =>
      ResponseDataObject<T>(
        error: json["error"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : fromJson!(json["data"]),
        validationErrors: json["validationErrors"] == null
            ? null
            : fromJsonErrors(json["validationErrors"]),
      );

  static ValidationError? fromJsonErrors(Map<String, dynamic> json) {
    if (json.isEmpty) return null;
    // Tomamos el primer error (o el único) del mapa
    final firstKey = json.keys.first;
    final firstErrorMessage = json[firstKey].toString();
    // Devolvemos el primer error como un ValidationError
    return ValidationError(message: firstErrorMessage);
  }

  static Paginate fromJsonPaginate(Map<String, dynamic> json) => Paginate(
        total: json["total"],
        pageCount: json["page_count"],
        page: json["page"],
        pageSize: json["page_size"],
      );
}
