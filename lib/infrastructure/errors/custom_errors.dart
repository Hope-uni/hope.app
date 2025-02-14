import 'package:toastification/toastification.dart';

class CustomError implements Exception {
  final String message;
  final ToastificationType typeNotification;
  final int? errorCode;

  CustomError(
    this.errorCode, {
    required this.message,
    required this.typeNotification,
  });
}
