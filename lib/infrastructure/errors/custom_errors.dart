import 'package:toastification/toastification.dart';

class CustomError implements Exception {
  final String message;
  final ToastificationType typeNotification;

  CustomError({required this.message, required this.typeNotification});
}
