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
  final bool isFormPosted;

  LoginFormState({
    this.isFormPosted = false,
    this.password = '',
    this.userName = '',
  });

  LoginFormState copyWith({
    String? userName,
    String? password,
    bool? isFormPosted,
  }) =>
      LoginFormState(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        isFormPosted: isFormPosted ?? this.isFormPosted,
      );
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Future<void> Function(String, String) loginUserCallback;

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

  void onFormSubmit() async {
    state = state.copyWith(isFormPosted: true);
    await loginUserCallback(state.userName, state.password);
    state = state.copyWith(isFormPosted: false);
  }
}

///////////////////////////////////////////////////////////////////////////////////////

final isVisiblePasswordProvider = StateProvider<bool>((ref) => true);
