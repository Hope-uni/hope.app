import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:toastification/toastification.dart';

class ErrorHandler {
  static Never handleError(Object error) {
    if (error is DioException) {
      final responseMapper = ResponseMapper.responseJsonToEntity<ResponseData>(
        json: error.response!.data,
      );

      final String message = responseMapper.validationErrors != null
          ? responseMapper.validationErrors!.message
          : (responseMapper.message.isNotEmpty
              ? responseMapper.message
              : S.current.Error_solicitud);

      throw CustomError(
        error.response!.statusCode!,
        message: message,
        typeNotification: ToastificationType.error,
      );
    } else {
      throw CustomError(
        null,
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
    }
  }
}
