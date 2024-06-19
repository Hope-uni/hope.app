import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueRepository = KeyValueStorageRepositoryImpl();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueRepository: keyValueRepository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageRepository keyValueRepository;
  final DioService dio = DioService();
  AuthNotifier({required this.keyValueRepository, required this.authRepository})
      : super(AuthState()) {
    checkAuthStatus();
  }

  void _setLoggedToken(Token token) async {
    try {
      await keyValueRepository.setValueStorage<String>(
        token.accessToken,
        'token',
      );
      await keyValueRepository.setValueStorage<String>(
        token.refreshToken,
        'refreshToken',
      );

      await dio.configureBearer();
      final mePermisson = await authRepository.mePermissions();

      final dataMe = mePermisson.data;
      _settearDataMe(dataMe!);

      state = state.copyWith(
        token: token,
        authStatus: AuthStatus.authenticated,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      _settearError(e.message);
    } catch (e) {
      _settearError('Error no controlado');
    }
  }

  Future<void> loginUser(String emailUsername, String password) async {
    try {
      final token = await authRepository.login(emailUsername, password);
      _setLoggedToken(token.data!);
    } on CustomError catch (e) {
      _settearError(e.message);
    } catch (e) {
      _settearError('Error no controlado');
    }
  }

  Future<void> checkAuthStatus() async {
    final String? token =
        await keyValueRepository.getValueStorage<String>('token');
    if (token == null) return logout();

    final itemToken = Token(accessToken: token, refreshToken: '');
    state = state.copyWith(
      token: itemToken,
      authStatus: AuthStatus.authenticated,
    );
    /* try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedToken(user);
    } catch (e) {
      logout();
    }*/
  }

  Future<void> logout() async {
    await keyValueRepository.deleteKeyStorage('token');
    await keyValueRepository.deleteKeyStorage('refreshToken');
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      token: null,
    );
  }

  void _settearError(String error) {
    logout();
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        token: null,
        errorMessage: error);
  }

  void _settearDataMe(Me me) async {
    await keyValueRepository.setValueStorage<String>(me.username, 'userName');
    await keyValueRepository.setValueStorage<String>(me.email, 'email');

    final permissonsList = me.roles.expand((role) => role.permissions).toList();

    final descriptionsPermissons =
        permissonsList.map((e) => e.description).toList();

    await keyValueRepository.setValueStorage<List<String>>(
        descriptionsPermissons, 'permissions');
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
