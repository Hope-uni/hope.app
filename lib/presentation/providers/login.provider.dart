import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/providers/providers.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final authNotifier = ref.watch(authProvider.notifier);
  return LoginFormNotifier(authNotifier: authNotifier);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final AuthNotifier authNotifier;

  LoginFormNotifier({required this.authNotifier}) : super(LoginFormState());

  void onUserNameChange(String value) {
    state = state.copyWith(
      userName: value,
      errorUserName: value.isNotEmpty ? '' : null,
    );
  }

  void onPasswordChange(String value) {
    state = state.copyWith(
      password: value,
      errorPassword: value.isNotEmpty ? '' : null,
    );
  }

  bool validInputs() {
    if (state.password.isEmpty || state.userName.isEmpty) {
      state = state.copyWith(
          errorPassword: state.password.isEmpty
              ? S.current.La_contrasena_es_requerida
              : '',
          errorUserName:
              state.userName.isEmpty ? S.current.El_usuario_es_requerido : '');

      return false;
    }
    if (state.password.length > 30 || state.password.length < 8) {
      state = state.copyWith(
          errorPassword:
              S.current.La_contrasena_debe_contener_entre_8_y_30_caracteres);
      return false;
    }
    state = state.copyWith(errorPassword: '', errorUserName: '');
    return true;
  }

  void onFormSubmit() async {
    state = state.copyWith(isFormPosted: true);
    await authNotifier.loginUser(
      emailUsername: state.userName,
      password: state.password,
    );
    state = state.copyWith(isFormPosted: false);
  }
}

class LoginFormState {
  final String userName;
  final String password;
  final String? errorPassword;
  final String? errorUserName;
  final bool isFormPosted;

  LoginFormState({
    this.isFormPosted = false,
    this.password = '',
    this.userName = '',
    this.errorPassword,
    this.errorUserName,
  });

  LoginFormState copyWith({
    String? userName,
    String? password,
    String? errorPassword,
    String? errorUserName,
    bool? isFormPosted,
  }) =>
      LoginFormState(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        errorPassword:
            errorPassword == '' ? null : errorPassword ?? this.errorPassword,
        errorUserName:
            errorUserName == '' ? null : errorUserName ?? this.errorUserName,
        isFormPosted: isFormPosted ?? this.isFormPosted,
      );
}

///////////////////////////////////////////////////////////////////////////////////////

final isVisiblePasswordProvider = StateProvider<bool>((ref) => true);
