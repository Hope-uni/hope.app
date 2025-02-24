import 'package:hope_app/domain/domain.dart';

abstract class AuthDataSource {
  Future<ResponseDataObject<Token>> login(
      String emailUsername, String password);

  Future<ResponseDataObject<ResponseDataObject>> forgotPassword(
      String emailOrUserName);

  Future<ResponseDataObject<Me>> mePermissions();

  Future<ResponseDataObject<ResponseDataObject>> changePassword(
      {required String password,
      required String newPassword,
      required String confirmNewPassword});
}
