import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:toastification/toastification.dart';

final passwordProvider = StateNotifierProvider.autoDispose<
    ResetPasswordNotifier, ResetPasswordState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return ResetPasswordNotifier(authRepository: authRepository);
});

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final AuthRepositoryImpl authRepository;

  ResetPasswordNotifier({required this.authRepository})
      : super(ResetPasswordState());

  void sendResetPassword() async {
    state = state.copyWith(isFormPosted: true);
    await sendEmailForgotPassword(state.emailOrUser);
    state = state.copyWith(isFormPosted: false);
  }

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

  void onEmailOrUser(String emailOrUser) {
    state = state.copyWith(
      emailOrUser: emailOrUser,
      errorEmailOrUser: emailOrUser.isNotEmpty ? '' : null,
    );
  }

  bool validInput() {
    if (state.emailOrUser.isEmpty) {
      state = state.copyWith(
        errorEmailOrUser: S.current.Debe_ingresar_el_nombre_de_usuario_o_correo,
      );
      return false;
    }
    return true;
  }

  void resetStateMessage() {
    state = state.copyWith(
      message: '',
    );
  }
}

class ResetPasswordState {
  final String? errorEmailOrUser;
  final String emailOrUser;
  final bool isFormPosted;
  final String message;
  final ToastificationType typeMessage;

  ResetPasswordState({
    this.isFormPosted = false,
    this.emailOrUser = '',
    this.errorEmailOrUser,
    this.typeMessage = ToastificationType.success,
    this.message = '',
  });

  ResetPasswordState copyWith({
    String? emailOrUser,
    bool? isFormPosted,
    String? errorEmailOrUser,
    ToastificationType? typeMessage,
    String? message,
  }) =>
      ResetPasswordState(
        emailOrUser: emailOrUser ?? this.emailOrUser,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        errorEmailOrUser: errorEmailOrUser == ''
            ? null
            : errorEmailOrUser ?? this.errorEmailOrUser,
        typeMessage: typeMessage ?? this.typeMessage,
        message: message ?? this.message,
      );
}
