import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final changePasswordProvider = StateNotifierProvider.autoDispose<
    ChangePasswordNotifier, ChangePasswordState>((ref) {
  final authRepository = ref.watch(authProvider.notifier);

  return ChangePasswordNotifier(
    authRepository: AuthRepositoryImpl(),
    keyValueRepository: KeyValueStorageRepositoryImpl(),
    authProviderNotifier: authRepository,
  );
});

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final AuthRepositoryImpl authRepository;
  final KeyValueStorageRepository keyValueRepository;
  final AuthNotifier authProviderNotifier;

  ChangePasswordNotifier(
      {required this.authProviderNotifier,
      required this.keyValueRepository,
      required this.authRepository})
      : super(
          ChangePasswordState(
            passwords: ChangePassword(
              password: '',
              newPassword: '',
              confirmNewPassword: '',
            ),
          ),
        );

  Future<void> changePassword() async {
    state = state.copyWith(isLoading: true);
    try {
      final response =
          await authRepository.changePassword(passwords: state.passwords!);
      state =
          state.copyWith(messageSuccess: response.message, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(messageError: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          messageError: S.current.Error_inesperado, isLoading: false);
    }
  }

  Future<void> changePasswordChild({required int idChild}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await authRepository.changePasswordChild(
        passwordsChild: state.passwords!,
        idChild: idChild,
      );

      state = state.copyWith(
        messageSuccess: response.message,
        isLoading: false,
      );
    } on CustomError catch (e) {
      state = state.copyWith(messageError: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          messageError: S.current.Error_inesperado, isLoading: false);
    }
  }

  void updateErrorField({required String fieldName, required String newValue}) {
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    ChangePassword passwords = state.passwords!;

    switch (fieldName) {
      case $password:
        if (newValue.isNotEmpty) {
          newValidationErrors.remove($password);
        }
        passwords = state.passwords!.copyWith(password: newValue);
        break;
      case $newPassword:
        if ($regexPassword.hasMatch(newValue)) {
          newValidationErrors.remove($newPassword);
        }
        passwords = state.passwords!.copyWith(newPassword: newValue);
        break;
      case $confirmNewPassword:
        if (newValue == state.passwords!.newPassword) {
          newValidationErrors.remove($confirmNewPassword);
        }
        passwords = state.passwords!.copyWith(confirmNewPassword: newValue);
        break;
      default:
        break;
    }
    state = state.copyWith(
      passwords: passwords,
      validationErrors: newValidationErrors,
    );
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.passwords!.password.isEmpty) {
      errors[$password] = S.current.La_contrasena_actual_no_puede_estar_vacia;
    }
    if (!$regexPassword.hasMatch(state.passwords!.newPassword)) {
      errors[$newPassword] = S.current
          .La_contrasena_debe_tener_entre_caracteres_ademas_contener_letras_y_numeros;
    }
    if (state.passwords!.newPassword != state.passwords!.confirmNewPassword) {
      errors[$confirmNewPassword] = S.current.Las_contrasena_no_coinciden;
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateResponse() => state = state.copyWith(messageError: '');

  Future<void> updateMe() async {
    await keyValueRepository.setValueStorage<bool>(true, $verified);

    final String? token =
        await KeyValueStorageRepositoryImpl().getValueStorage<String>($token);

    final refreshToken = await KeyValueStorageRepositoryImpl()
        .getValueStorage<String>($refreshToken);

    final Token tokenFinal = Token(
      accessToken: token!,
      refreshToken: refreshToken!,
    );

    authProviderNotifier.setLoggedToken(token: tokenFinal);
  }

  void resetState() {
    state = ChangePasswordState(
      passwords: ChangePassword(
        password: '',
        newPassword: '',
        confirmNewPassword: '',
      ),
    );
  }

  void viewPassword({required String fieldName, required bool newValue}) {
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
  final ChangePassword? passwords;
  final String? messageError;
  final String? messageSuccess;
  final bool? isLoading;
  final Map<String, String?> validationErrors;
  final Map<String, bool> viewPasswords;

  ChangePasswordState({
    this.passwords,
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
    final ChangePassword? passwords,
    final String? messageError,
    final String? messageSuccess,
    final bool? isLoading,
    final Map<String, String?>? validationErrors,
    final Map<String, bool>? viewPasswords,
  }) =>
      ChangePasswordState(
        passwords: passwords ?? this.passwords,
        messageError:
            messageError == '' ? null : messageError ?? this.messageError,
        messageSuccess: messageSuccess ?? this.messageSuccess,
        isLoading: isLoading ?? this.isLoading,
        validationErrors: validationErrors ?? this.validationErrors,
        viewPasswords: viewPasswords ?? this.viewPasswords,
      );
}
