class Me {
  int id;
  String username;
  String email;
  Profile profile;
  List<Role> roles;

  Me({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
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

class Profile {
  int profileId;
  String firstName;
  String? secondName;
  String surname;
  String? secondSurname;
  String image;
  String identificationNumber;
  int? phoneNumber;
  int? telephone;
  String address;
  String birthday;
  String gender;

  Profile({
    required this.profileId,
    required this.firstName,
    required this.secondName,
    required this.surname,
    required this.secondSurname,
    required this.image,
    required this.identificationNumber,
    required this.phoneNumber,
    required this.telephone,
    required this.address,
    required this.birthday,
    required this.gender,
  });
}
