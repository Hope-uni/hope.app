import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:toastification/toastification.dart';

final passwordProvider =
    StateNotifierProvider<PasswordNotifier, PasswordState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return PasswordNotifier(authRepository: authRepository);
});

class PasswordState {
  final String message;
  final ToastificationType typeMessage;

  PasswordState({
    this.typeMessage = ToastificationType.success,
    this.message = '',
  });

  PasswordState copyWith({
    ToastificationType? typeMessage,
    String? message,
  }) =>
      PasswordState(
        typeMessage: typeMessage ?? this.typeMessage,
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
        ToastificationType.success,
      );
    } on CustomError catch (e) {
      _setStatePassword(e.message, e.typeNotification);
    } catch (e) {
      _setStatePassword(
          S.current.Error_no_controlado, ToastificationType.error);
    }
  }

  void _setStatePassword(String message, ToastificationType messageType) {
    state = state.copyWith(message: message, typeMessage: messageType);
  }
}
