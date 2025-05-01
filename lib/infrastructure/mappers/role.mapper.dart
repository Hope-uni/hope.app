import 'package:hope_app/domain/domain.dart';

class RoleMapper {
  static Role roleFromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        permissions: json["permissions"] == null
            ? null
            : List<Permission>.from(
                (json["permissions"] ?? []).map((x) => permissionFromJson(x))),
      );

  static Permission permissionFromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        code: json["code"],
        name: json["name"],
      );
}
