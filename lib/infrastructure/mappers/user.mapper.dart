import 'package:hope_app/domain/entities/user.entities.dart' show User;

class UserMapper {
  static fromJsonUser(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
      );
}
