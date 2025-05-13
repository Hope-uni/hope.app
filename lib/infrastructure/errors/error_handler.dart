import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart'
    show handleUnauthorized;
import 'package:toastification/toastification.dart';

class ErrorHandler {
  static Never handleError(Object error) {
    if (error is DioException) {
      final responseMapper = ResponseMapper.responseJsonToEntity<Rol>(
        json: error.response!.data,
        fromJson: RolMapper.rolFromJson,
      );

      final String message = responseMapper.validationErrors != null
          ? responseMapper.validationErrors!.message
          : (responseMapper.message.isNotEmpty
              ? responseMapper.message
              : S.current.Error_solicitud);

      // 👇 Aquí interceptas el 401, llama al logout automáticamente
      if (responseMapper.statusCode == 401) {
        handleUnauthorized(errorMessage: message);
      }

      throw CustomError(
        errorCode: error.response!.statusCode!,
        dataError: responseMapper.data,
        message: message,
        typeNotification: ToastificationType.error,
      );
    } else {
      throw CustomError(
        errorCode: null,
        dataError: null,
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
    }
  }
}
