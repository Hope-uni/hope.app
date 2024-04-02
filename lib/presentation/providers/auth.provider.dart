import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueRepository = KeyValueStorageRepositoryImpl();
  return AuthNotifier(
      authRepository: authRepository, keyValueRepository: keyValueRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageRepository keyValueRepository;

  AuthNotifier({required this.keyValueRepository, required this.authRepository})
      : super(AuthState()) {
    checkAuthStatus();
  }

  void _setLoggedToken(Token token) async {
    await keyValueRepository.setValueStorage(token.accessToken!, 'token');
    state = state.copyWith(
      token: token,
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final token = await authRepository.login(email, password);
      _setLoggedToken(token.data!);
      // ignore: empty_catches
    } on CustomError catch (e) {
      settearError(e.message);
    } catch (e) {
      settearError('Error no controlado');
    }
  }

  Future<void> checkAuthStatus() async {
    final token = await keyValueRepository.getValueStorage<String>('token');
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
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      token: null,
    );
  }

  void settearError(String error) {
    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        token: null,
        errorMessage: error);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final Token? token;
  final String errorMessage;

  AuthState(
      {this.token,
      this.errorMessage = '',
      this.authStatus = AuthStatus.checking});

  AuthState copyWith(
          {AuthStatus? authStatus, Token? token, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          errorMessage: errorMessage ?? this.errorMessage,
          token: token ?? this.token);
}
