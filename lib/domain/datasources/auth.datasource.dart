import 'package:hope_app/domain/domain.dart';

abstract class AuthDataSource {
  Future<ResponseDataObject<Token>> login(
    String emailUsername,
    String password,
  );

  Future<ResponseDataObject<ResponseData>> forgotPassword(
    String emailOrUserName,
  );

  Future<ResponseDataObject<Me>> mePermissions();

  Future<ResponseDataObject<ResponseData>> changePassword({
    required ChangePassword passwords,
  });

  Future<ResponseDataObject<ResponseData>> changePasswordChild({
    required ChangePassword passwordsChild,
    required int idChild,
  });
}
