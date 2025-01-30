import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/password.provider.dart';

final resetPasswordFormProvider = StateNotifierProvider.autoDispose<
    ResetPasswordNotifier, ResetPasswordState>((ref) {
  final forgotPasswordCallback =
      ref.watch(passwordProvider.notifier).sendEmailForgotPassword;
  return ResetPasswordNotifier(forgotPasswordCallback: forgotPasswordCallback);
});

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final Future<void> Function(String emailOrUsername) forgotPasswordCallback;
  ResetPasswordNotifier({required this.forgotPasswordCallback})
      : super(ResetPasswordState());

  void sendResetPassword() async {
    state = state.copyWith(isFormPosted: true);
    await forgotPasswordCallback(state.emailOrUser);
    state = state.copyWith(isFormPosted: false);
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
}

class ResetPasswordState {
  final String? errorEmailOrUser;
  final String emailOrUser;
  final bool isFormPosted;

  ResetPasswordState({
    this.isFormPosted = false,
    this.emailOrUser = '',
    this.errorEmailOrUser,
  });

  ResetPasswordState copyWith({
    String? emailOrUser,
    bool? isFormPosted,
    String? errorEmailOrUser,
  }) =>
      ResetPasswordState(
        emailOrUser: emailOrUser ?? this.emailOrUser,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        errorEmailOrUser: errorEmailOrUser == ''
            ? null
            : errorEmailOrUser ?? this.errorEmailOrUser,
      );
}
