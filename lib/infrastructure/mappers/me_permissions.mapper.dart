import 'package:hope_app/domain/domain.dart';

class MePermissionsMapper {
  static Me mePermissionsJsonToEntity(
    Map<String, dynamic> json,
  ) =>
      Me(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        roles:
            List<Role>.from((json["roles"] ?? []).map((x) => roleFromJson(x))),
      );

  static Role roleFromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        permissions: List<Permission>.from(
            (json["permissions"] ?? []).map((x) => permissionFromJson(x))),
      );

  static Permission permissionFromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        description: json["description"],
        status: json["status"],
      );
}
