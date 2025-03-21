import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueRepository = KeyValueStorageRepositoryImpl();
  final profileStateNotifier = ref.read(profileProvider.notifier);
  final childrenStateNotifier = ref.read(childrenProvider.notifier);
  final activitiesStateNotifier = ref.read(activitiesProvider.notifier);
  final phaseStateNotifier = ref.read(phasesProvider.notifier);
  final childStateNotifier = ref.read(childProvider.notifier);
  final activityStateNotifier = ref.read(activityProvider.notifier);

  return AuthNotifier(
    authRepository: authRepository,
    keyValueRepository: keyValueRepository,
    profileStateNotifier: profileStateNotifier,
    childrenStateNotifier: childrenStateNotifier,
    activitiesStateNotifier: activitiesStateNotifier,
    activityStateNotifier: activityStateNotifier,
    phaseStateNotifier: phaseStateNotifier,
    childStateNotifier: childStateNotifier,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageRepository keyValueRepository;
  final DioService dio = DioService();

  final ProfileNotifier profileStateNotifier;
  final ChildrenNotifier childrenStateNotifier;
  final ActivitiesNotifier activitiesStateNotifier;
  final PhasesNotifier phaseStateNotifier;
  final ChildNotifier childStateNotifier;
  final ActivityNotifier activityStateNotifier;

  AuthNotifier({
    required this.profileStateNotifier,
    required this.childrenStateNotifier,
    required this.keyValueRepository,
    required this.authRepository,
    required this.activitiesStateNotifier,
    required this.phaseStateNotifier,
    required this.childStateNotifier,
    required this.activityStateNotifier,
  }) : super(AuthState());

  void setLoggedToken(Token token) async {
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

      final dataMe = mePermisson.data;
      settearDataMe(dataMe!, token);
    } on CustomError catch (e) {
      if (e.errorCode == 401) {
        await keyValueRepository.setValueStorage<bool>(false, $verified);
        profileStateNotifier.updateIsLoading(false);

        chagesStateAuthenticated(token);
        return;
      }
      _settearError(e.message);
    } catch (e) {
      _settearError(S.current.Error_no_controlado);
    }
  }

  void chagesStateAuthenticated(Token token) {
    state = state.copyWith(
      token: token,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> loginUser(String emailUsername, String password) async {
    try {
      final token = await authRepository.login(emailUsername, password);
      setLoggedToken(token.data!);
    } on CustomError catch (e) {
      _settearError(e.message);
    } catch (e) {
      _settearError(S.current.Error_no_controlado);
    }
  }

  Future<void> logout() async {
    _resetTokens();
    await keyValueRepository.deleteKeyStorage($userName);
    await keyValueRepository.deleteKeyStorage($email);
    await keyValueRepository.deleteKeyStorage($profile);
    await keyValueRepository.deleteKeyStorage($permissions);
    await keyValueRepository.deleteKeyStorage($verified);
    await keyValueRepository.deleteKeyStorage($roles);

    profileStateNotifier.resetProfile();
    childrenStateNotifier.resetState();
    activitiesStateNotifier.resetState();
    phaseStateNotifier.resetState();
    childStateNotifier.resetChild();
    activityStateNotifier.resetState();

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      token: null,
    );
  }

  void _settearError(String error) {
    _resetTokens();
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        token: null,
        errorMessage: error);
  }

  void _resetTokens() async {
    await keyValueRepository.deleteKeyStorage($token);
    await keyValueRepository.deleteKeyStorage($refreshToken);
  }

  void settearDataMe(Me me, token) async {
    await keyValueRepository.setValueStorage<bool>(true, $verified);
    await keyValueRepository.setValueStorage<String>(me.username, $userName);
    await keyValueRepository.setValueStorage<String>(me.email, $email);

    await keyValueRepository.setValueStorage<String>(
        jsonEncode(MePermissionsMapper.toJsonProfile(me.profile)), $profile);

    final roles = me.roles.map((e) => e.name).toList();

    await keyValueRepository.setValueStorage<List<String>>(roles, $roles);

    final permissonsList = me.roles.expand((role) => role.permissions).toList();

    final descriptionsPermissons =
        permissonsList.map((e) => e.description).toList();

    await keyValueRepository.setValueStorage<List<String>>(
        descriptionsPermissons, $permissions);

    profileStateNotifier.loadProfileAndPermmisions();

    chagesStateAuthenticated(token);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final Token? token;
  final String? errorMessage;

  AuthState(
      {this.token, this.errorMessage, this.authStatus = AuthStatus.checking});

  AuthState copyWith(
          {AuthStatus? authStatus, Token? token, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          errorMessage:
              errorMessage == '' ? null : errorMessage ?? this.errorMessage,
          token: token ?? this.token);
}
