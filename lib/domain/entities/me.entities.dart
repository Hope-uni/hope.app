class Me {
  int id;
  String username;
  String email;
  bool userVerified;
  Profile? profile;
  List<Role> roles;

  Me({
    required this.id,
    required this.username,
    required this.email,
    required this.userVerified,
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
  String name;
  String code;

  Permission({
    required this.id,
    required this.name,
    required this.code,
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
  int age;
  String gender;
  String? imageUrl;
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
    required this.age,
    required this.gender,
    this.imageUrl,
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
    int? age,
    String? telephone,
    String? phoneNumber,
    int? profileId,
    String? gender,
    String? imageUrl,
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
      age: age ?? this.age,
      telephone: telephone ?? this.telephone,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileId: profileId ?? this.profileId,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
      isMonochrome: isMonochrome ?? this.isMonochrome,
    );
  }
}
