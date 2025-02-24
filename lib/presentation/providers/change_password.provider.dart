import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>((ref) {
  final authRepository = ref.watch(authProvider.notifier);
  return ChangePasswordNotifier(
    dataSourceAuth: AuthRepositoryImpl(),
    keyValueRepository: KeyValueStorageRepositoryImpl(),
    authProviderNotifier: authRepository,
  );
});

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final AuthRepositoryImpl dataSourceAuth;
  final KeyValueStorageRepository keyValueRepository;
  final AuthNotifier authProviderNotifier;

  ChangePasswordNotifier(
      {required this.authProviderNotifier,
      required this.keyValueRepository,
      required this.dataSourceAuth})
      : super(ChangePasswordState());

  Future<void> changePassword() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await dataSourceAuth.changePassword(
        confirmNewPassword: state.confirmNewPassword!,
        newPassword: state.newPassword!,
        password: state.password!,
      );
      state =
          state.copyWith(messageSuccess: response.message, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(messageError: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          messageError: S.current.Error_inesperado, isLoading: false);
    }
  }

  void updateErrorField(String fieldName, String newValue) {
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    switch (fieldName) {
      case $password:
        if (newValue.isNotEmpty) {
          newValidationErrors.remove($password);
        }

        state = state.copyWith(
          validationErrors: newValidationErrors,
          password: newValue,
        );
        break;
      case $newPassword:
        if ($regexPassword.hasMatch(newValue)) {
          newValidationErrors.remove($newPassword);
        }

        state = state.copyWith(
          validationErrors: newValidationErrors,
          newPassword: newValue,
        );
        break;
      case $confirmNewPassword:
        if (newValue == state.newPassword) {
          newValidationErrors.remove($confirmNewPassword);
        }

        state = state.copyWith(
          validationErrors: newValidationErrors,
          confirmNewPassword: newValue,
        );
        break;
      default:
        break;
    }
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.password == null || state.password!.isEmpty) {
      errors[$password] = S.current.La_contrasena_actual_no_puede_estar_vacia;
    }
    if (state.newPassword == null ||
        !$regexPassword.hasMatch(state.newPassword!)) {
      errors[$newPassword] = S.current
          .La_contrasena_debe_tener_entre_caracteres_ademas_contener_letras_y_numeros;
    }
    if (state.confirmNewPassword == null ||
        state.newPassword! != state.confirmNewPassword!) {
      errors[$confirmNewPassword] = S.current.Las_contrasena_no_coinciden;
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateErrorMessage() {
    state = state.copyWith(messageError: '');
  }

  Future<void> updateMe() async {
    await keyValueRepository.setValueStorage<bool>(true, $verified);

    final String? token =
        await KeyValueStorageRepositoryImpl().getValueStorage<String>($token);

    final refreshToken = await KeyValueStorageRepositoryImpl()
        .getValueStorage<String>($refreshToken);

    final Token tokenFinal =
        Token(accessToken: token!, refreshToken: refreshToken!);

    authProviderNotifier.setLoggedToken(tokenFinal);
  }

  void resetState() {
    state = ChangePasswordState();
  }

  void viewPassword(String fieldName, bool newValue) {
    final Map<String, bool> newViewPasswords = Map.from(state.viewPasswords);

    switch (fieldName) {
      case $password:
        newViewPasswords[$password] = newValue;
        break;
      case $newPassword:
        newViewPasswords[$newPassword] = newValue;
        break;
      case $confirmNewPassword:
        newViewPasswords[$confirmNewPassword] = newValue;
        break;
      default:
        break;
    }

    state = state.copyWith(viewPasswords: newViewPasswords);
  }
}

class ChangePasswordState {
  final String? password;
  final String? newPassword;
  final String? confirmNewPassword;
  final String? messageError;
  final String? messageSuccess;
  final bool? isLoading;
  final Map<String, String?> validationErrors;
  final Map<String, bool> viewPasswords;

  ChangePasswordState({
    this.password,
    this.newPassword,
    this.confirmNewPassword,
    this.messageError,
    this.messageSuccess,
    this.isLoading,
    this.validationErrors = const {},
    this.viewPasswords = const {
      $password: true,
      $newPassword: false,
      $confirmNewPassword: false
    },
  });

  ChangePasswordState copyWith({
    final String? password,
    final String? newPassword,
    final String? confirmNewPassword,
    final String? messageError,
    final String? messageSuccess,
    final bool? isLoading,
    final Map<String, String?>? validationErrors,
    final Map<String, bool>? viewPasswords,
  }) =>
      ChangePasswordState(
        password: password ?? this.password,
        newPassword: newPassword ?? this.newPassword,
        confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
        messageError:
            messageError == '' ? null : messageError ?? this.messageError,
        messageSuccess: messageSuccess ?? this.messageSuccess,
        isLoading: isLoading ?? this.isLoading,
        validationErrors: validationErrors ?? this.validationErrors,
        viewPasswords: viewPasswords ?? this.viewPasswords,
      );
}
