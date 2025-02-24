import 'package:hope_app/domain/domain.dart';

abstract class AuthRepository {
  Future<ResponseDataObject<Token>> login(
      String emailUsername, String password);

  Future<ResponseDataObject<ResponseData>> forgotPassword(
      String emailOrUserName);

  Future<ResponseDataObject<Me>> mePermissions();

  Future<ResponseDataObject<ResponseData>> changePassword(
      {required String password,
      required String newPassword,
      required String confirmNewPassword});
}
