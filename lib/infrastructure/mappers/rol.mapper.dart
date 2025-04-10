import 'package:hope_app/domain/entities/rol.entities.dart';
import 'package:hope_app/infrastructure/mappers/role.mapper.dart';

class RolMapper {
  static Rol rolFromJson(Map<String, dynamic> json) => Rol(
        role: RoleMapper.roleFromJson(json["role"]),
      );
}
