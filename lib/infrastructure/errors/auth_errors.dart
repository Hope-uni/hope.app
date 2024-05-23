class CustomError implements Exception {
  final String message;
  final int statuCode;

  CustomError({required this.message, required this.statuCode});
}
