import 'package:hope_app/domain/domain.dart';

class AuthDataSourceImpl extends AuthDataSource {
  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> resetPassword(String emailOrUserName) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
