import 'package:hope_app/domain/domain.dart';

abstract class AuthDataSource {
  Future<ResponseDataObject<Token>> login(String email, String password);
  Future<ResponseDataObject<Token>> resetPassword(String emailOrUserName);
  Future<ResponseDataObject<Token>> checkAuthStatus(String token);
}
