import 'package:hope_app/domain/domain.dart';

abstract class AuthDataSource {
  Future<ResponseDataObject<Token>> login(
      String emailUsername, String password);
  Future<ResponseDataObject> forgotPassword(String emailOrUserName);
  Future<ResponseDataObject<Me>> mePermissions();
}
