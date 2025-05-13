import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:toastification/toastification.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueRepository = KeyValueStorageRepositoryImpl();
  final profileStateNotifier = ref.read(profileProvider.notifier);

  return AuthNotifier(
    authRepository: authRepository,
    keyValueRepository: keyValueRepository,
    profileStateNotifier: profileStateNotifier,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageRepository keyValueRepository;
  final DioService dio = DioService();

  final ProfileNotifier profileStateNotifier;

  AuthNotifier({
    required this.profileStateNotifier,
    required this.keyValueRepository,
    required this.authRepository,
  }) : super(AuthState());

  void setLoggedToken({required Token token}) async {
    try {
      await keyValueRepository.setValueStorage<String>(
        token.accessToken,
        $token,
      );
      await keyValueRepository.setValueStorage<String>(
        token.refreshToken,
        $refreshToken,
      );

      await dio.configureBearer();
      final mePermisson = await authRepository.mePermissions();

      // 🔐 Validar el rol antes de continuar
      final dataMe = mePermisson.data;

      final roles = dataMe!.roles.map((item) => item.name);
      if (!roles.contains($paciente) &&
          !roles.contains($tutor) &&
          !roles.contains($terapeuta)) {
        state = state.copyWith(isloading: false);
        throw CustomError(
          errorCode: null,
          dataError: null,
          message: S.current.No_esta_autorizado_para_iniciar_sesion_en_la_APP,
          typeNotification: ToastificationType.error,
        );
      }

      if (roles.contains($paciente) && state.isTablet == false) {
        _settearError(error: '');

        throw CustomError(
          errorCode: null,
          dataError: null,
          message:
              S.current.Los_pacientes_solo_pueden_iniciar_sesion_en_tablets,
          typeNotification: ToastificationType.error,
        );
      }

      settearDataMe(me: dataMe, token: token);
      state = state.copyWith(isloading: false);
    } on CustomError catch (e) {
      if (e.errorCode == 403 && e.dataError != null) {
        //Validando el Rol si el usuario no esta verificado
        await keyValueRepository.setValueStorage<bool>(false, $verified);

        final rol = e.dataError!.role.name;

        await keyValueRepository.setValueStorage<List<String>>([rol], $roles);

        profileStateNotifier.updateIsLoading(isLoading: false);

        if (rol != $terapeuta && rol != $paciente && rol != $tutor) {
          _settearError(
            error: S.current.No_esta_autorizado_para_iniciar_sesion_en_la_APP,
          );
        }
        chagesStateAuthenticated(token: token);

        return;
      }
      _settearError(error: e.message);
    } catch (e) {
      _settearError(error: S.current.Error_no_controlado);
    }
  }

  void chagesStateAuthenticated({required Token token}) {
    state = state.copyWith(
      token: token,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  void chagesStateNoAuthenticated() {
    state = state.copyWith(
      token: null,
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: '',
    );
  }

  Future<void> loginUser({
    required String emailUsername,
    required String password,
  }) async {
    try {
      state = state.copyWith(isloading: true);
      final token = await authRepository.login(emailUsername, password);
      setLoggedToken(token: token.data!);
    } on CustomError catch (e) {
      _settearError(error: e.message);
      state = state.copyWith(isloading: false);
    } catch (e) {
      _settearError(error: S.current.Error_no_controlado);
      state = state.copyWith(isloading: false);
    }
  }

  Future<void> logout({String? errorUser}) async {
    _resetTokens();
    await keyValueRepository.deleteKeyStorage($userName);
    await keyValueRepository.deleteKeyStorage($email);
    await keyValueRepository.deleteKeyStorage($profile);
    await keyValueRepository.deleteKeyStorage($permissions);
    await keyValueRepository.deleteKeyStorage($verified);
    await keyValueRepository.deleteKeyStorage($roles);

    profileStateNotifier.resetProfile();

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      token: null,
      errorMessage: errorUser,
    );
  }

  void _settearError({required String error}) {
    _resetTokens();
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      token: null,
      errorMessage: error,
      isloading: false,
    );
  }

  void updateResponse() => state = state.copyWith(errorMessage: '');

  void updateIsTablet({required bool isTablet}) {
    state = state.copyWith(isTablet: isTablet);
  }

  void _resetTokens() async {
    await keyValueRepository.deleteKeyStorage($token);
    await keyValueRepository.deleteKeyStorage($refreshToken);
  }

  void settearDataMe({required Me me, required Token token}) async {
    await keyValueRepository.setValueStorage<bool>(me.userVerified, $verified);
    await keyValueRepository.setValueStorage<String>(me.username, $userName);
    await keyValueRepository.setValueStorage<String>(me.email, $email);

    await keyValueRepository.setValueStorage<String>(
        jsonEncode(MePermissionsMapper.toJsonProfile(me.profile!)), $profile);

    final roles = me.roles.map((e) => e.name).toList();

    await keyValueRepository.setValueStorage<List<String>>(roles, $roles);

    final permissonsList =
        me.roles.expand((role) => role.permissions!).toList();

    final descriptionsPermissons = permissonsList.map((e) => e.code).toList();

    await keyValueRepository.setValueStorage<List<String>>(
        descriptionsPermissons, $permissions);

    await profileStateNotifier.loadProfileAndPermmisions();

    chagesStateAuthenticated(token: token);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final bool? isloading;
  final AuthStatus authStatus;
  final Token? token;
  final String? errorMessage;
  final bool? isTablet;

  AuthState({
    this.isloading,
    this.isTablet,
    this.token,
    this.errorMessage,
    this.authStatus = AuthStatus.checking,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    bool? isloading,
    bool? isTablet,
    Token? token,
    String? errorMessage,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        isloading: isloading ?? this.isloading,
        isTablet: isTablet ?? this.isTablet,
        errorMessage:
            errorMessage == '' ? null : errorMessage ?? this.errorMessage,
        token: token ?? this.token,
      );
}
