import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});

class LoginFormState {
  final String userName;
  final String password;

  LoginFormState({
    this.password = '',
    this.userName = '',
  });

  LoginFormState copyWith({
    String? userName,
    String? password,
  }) =>
      LoginFormState(
          userName: userName ?? this.userName,
          password: password ?? this.password);
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier() : super(LoginFormState());

  void onUserNameChange(String value) {
    final newUserName = value;
    state = state.copyWith(userName: newUserName);
  }

  void onPasswordChange(String value) {
    final newPassword = value;
    state = state.copyWith(password: newPassword);
  }

  bool validateInputs() {
    if (state.password.isEmpty || state.userName.isEmpty) return true;
    return false;
  }
}

///////////////////////////////////////////////////////////////////////////////////////

final isClicLoginProvider = StateProvider<bool>((ref) => false);
final isVisiblePasswordProvider = StateProvider<bool>((ref) => true);
