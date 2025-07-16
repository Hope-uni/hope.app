import 'package:hope_app/domain/domain.dart';

class ChangePasswordMapper {
  static Map<String, dynamic> toJson(ChangePassword passwords) => {
        "password": passwords.password,
        "newPassword": passwords.newPassword,
        "confirmNewPassword": passwords.confirmNewPassword,
      };
}
