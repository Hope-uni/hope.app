class Me {
  int id;
  String username;
  String email;
  bool userVerified;
  String? imageUrl;
  Profile? profile;
  List<Role> roles;

  Me({
    required this.id,
    required this.username,
    required this.email,
    required this.userVerified,
    required this.imageUrl,
    required this.roles,
    this.profile,
  });
}

class Role {
  int id;
  String name;
  List<Permission>? permissions;

  Role({
    required this.id,
    required this.name,
    this.permissions,
  });
}

class Permission {
  int id;
  bool status;
  String name;
  String code;

  Permission({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
  });
}

class Profile {
  int profileId;
  String fullName;
  String firstName;
  String? secondName;
  String surname;
  String? secondSurname;
  String? identificationNumber;
  String? phoneNumber;
  String? telephone;
  String address;
  String birthday;
  String gender;
  bool? isMonochrome;

  Profile({
    required this.profileId,
    required this.fullName,
    required this.firstName,
    required this.secondName,
    required this.surname,
    required this.secondSurname,
    required this.identificationNumber,
    required this.phoneNumber,
    required this.telephone,
    required this.address,
    required this.birthday,
    required this.gender,
    this.isMonochrome,
  });

  Profile copyWith({
    String? fullName,
    String? firstName,
    String? secondName,
    String? surname,
    String? secondSurname,
    String? identificationNumber,
    String? address,
    String? birthday,
    String? telephone,
    String? phoneNumber,
    int? profileId,
    String? gender,
    bool? isMonochrome,
  }) {
    return Profile(
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      surname: surname ?? this.surname,
      secondSurname: secondSurname ?? this.secondSurname,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      telephone: telephone ?? this.telephone,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileId: profileId ?? this.profileId,
      gender: gender ?? this.gender,
      isMonochrome: isMonochrome ?? this.isMonochrome,
    );
  }
}
