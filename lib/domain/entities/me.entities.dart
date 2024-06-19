class Me {
  int id;
  String username;
  String email;
  List<Role> roles;

  Me({
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
  });
}

class Role {
  int id;
  String name;
  List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.permissions,
  });
}

class Permission {
  int id;
  String description;
  bool status;

  Permission({
    required this.id,
    required this.description,
    required this.status,
  });
}
