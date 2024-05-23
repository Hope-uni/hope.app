import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

final passwordProvider =
    StateNotifierProvider<PasswordNotifier, PasswordState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return PasswordNotifier(authRepository: authRepository);
});

class PasswordState {
  final String message;
  final int statusCode;

  PasswordState({
    this.statusCode = 0,
    this.message = '',
  });

  PasswordState copyWith({
    int? statusCode,
    String? message,
  }) =>
      PasswordState(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
      );
}

class PasswordNotifier extends StateNotifier<PasswordState> {
  final AuthRepository authRepository;

  PasswordNotifier({required this.authRepository}) : super(PasswordState());

  Future<void> sendEmailForgotPassword(String emailOrUsername) async {
    try {
      final responseForgotPassword =
          await authRepository.forgotPassword(emailOrUsername);

      _setStatePassword(
        responseForgotPassword.message,
        responseForgotPassword.statusCode,
      );
    } on CustomError catch (e) {
      _setStatePassword(e.message, e.statuCode);
    } catch (e) {
      _setStatePassword('Error no controlado', 501);
    }
  }

  void _setStatePassword(String message, int statusCode) {
    state = state.copyWith(message: message, statusCode: statusCode);
  }
}
