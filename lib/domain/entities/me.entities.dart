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
  //String? fullName; //TODO: Cambiar cuando el endpoint ya lo devuelva
  String firstName;
  String? secondName;
  String surname;
  String? secondSurname;
  String? image;
  String identificationNumber;
  String phoneNumber;
  String? telephone;
  String address;
  String birthday;
  String gender;

  Profile({
    required this.profileId,
    //this.fullName, //TODO: Cambiar cuando el endpoint ya lo devuelva
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

  Profile copyWith({
    //String? fullName,//TODO: Cambiar cuando el endpoint ya lo devuelva
    String? firstName,
    String? secondName,
    String? surname,
    String? secondSurname,
    String? identificationNumber,
    String? address,
    String? birthday,
    String? telephone,
    String? phoneNumber,
    String? image,
    int? profileId,
    String? gender,
  }) {
    return Profile(
      //fullName: fullName ?? this.fullName,//TODO: Cambiar cuando el endpoint ya lo devuelva
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      surname: surname ?? this.surname,
      secondSurname: secondSurname ?? this.secondSurname,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      telephone: telephone ?? this.telephone,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      profileId: profileId ?? this.profileId,
      gender: gender ?? this.gender,
    );
  }
}
