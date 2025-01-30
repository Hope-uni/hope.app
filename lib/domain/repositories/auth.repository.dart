import 'package:hope_app/domain/domain.dart';

abstract class AuthRepository {
  Future<ResponseDataObject<Token>> login(
      String emailUsername, String password);
  Future<ResponseDataObject> forgotPassword(String emailOrUserName);
  Future<ResponseDataObject<Me>> mePermissions();

  Future<ResponseDataObject<Token>> checkAuthStatus(String token);
}
