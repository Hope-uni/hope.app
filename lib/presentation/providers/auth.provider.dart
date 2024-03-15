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

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> checkAuthStatus() async {
    final token = await keyValueRepository.getValueStorage<String>('token');

    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  Future<void> logout() async {
    await keyValueRepository.deleteKeyStorage('token');
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
    );
  }

  void _setLoggedUser(User user) async {
    await keyValueRepository.setValueStorage(user.token, 'token');
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.user,
      this.errorMessage = '',
      this.authStatus = AuthStatus.checking});

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          errorMessage: errorMessage ?? this.errorMessage,
          user: user ?? this.user);
}
