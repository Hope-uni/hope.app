import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class PasswordState {
  //TODO: Probablemente cambiar a interfaz cuando el endpoint este listo
  final String? message;
  final int statusCode;

  PasswordState({
    this.statusCode = 0,
    this.message,
  });

  PasswordState copyWith({
    int? statusCode,
    String? message,
  }) =>
      PasswordState(
        statusCode: statusCode ?? this.statusCode,
        message: message == '' ? null : message ?? this.message,
      );
}

class PasswordNotifier extends StateNotifier<PasswordState> {
  PasswordNotifier() : super(PasswordState());

  /*TODO: Cambiar todo el metodo cuando este listo el endpoint*/
  Future<void> sendEmailResetPassword() async {
    try {
      // final response = await resetPasswordRepository.reset(email);
      _setStatePassword(
          'Se envio solicitud de restablecer contraseña correctamente');
    } on CustomError catch (e) {
      _setStatePassword(e.message);
    } catch (e) {
      _setStatePassword('Error no controlado');
    }
  }

  void _setStatePassword(String message) {
    state = state.copyWith(message: message, statusCode: 200);
  }
}

final passwordProvider =
    StateNotifierProvider<PasswordNotifier, PasswordState>((ref) {
  return PasswordNotifier();
});
