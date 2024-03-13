import 'package:hope_app/domain/domain.dart';

abstract class AuthDataSource {
  Future<User> login(String email, String password);
  Future<User> resetPassword(String emailOrUserName);
  Future<User> checkAuthStatus(String token);
}
