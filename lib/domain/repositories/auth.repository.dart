import 'package:hope_app/domain/domain.dart';

abstract class AuthRepository {
  Future<ResponseData<Token>> login(String email, String password);
  Future<ResponseData<Token>> resetPassword(String emailOrUserName);
  Future<ResponseData<Token>> checkAuthStatus(String token);
}
