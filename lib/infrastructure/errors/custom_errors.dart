import 'package:hope_app/domain/domain.dart';
import 'package:toastification/toastification.dart';

class CustomError implements Exception {
  final String message;
  final ToastificationType typeNotification;
  final int? errorCode;
  final Rol? dataError;

  CustomError({
    required this.errorCode,
    required this.dataError,
    required this.message,
    required this.typeNotification,
  });
}
