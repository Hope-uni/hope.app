import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/presentation/providers/providers.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  return LoginFormNotifier(loginUserCallback: loginUserCallback);
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
  final Function(String, String) loginUserCallback;
  LoginFormNotifier({required this.loginUserCallback})
      : super(LoginFormState());

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

  onFormSubmit() async {
    await loginUserCallback(state.userName, state.password);
  }
}

///////////////////////////////////////////////////////////////////////////////////////

final isClicLoginProvider = StateProvider<bool>((ref) => false);
final isVisiblePasswordProvider = StateProvider<bool>((ref) => true);
