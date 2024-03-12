import 'package:hope_app/domain/domain.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> resetPassword(String emailUser);
  Future<User> checkAuthStatus(String token);
}
