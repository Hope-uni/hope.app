class ProfilePerson {
  int? id;
  String firstName;
  String? secondName;
  String surname;
  String? secondSurname;
  String? image;
  String username;
  String email;
  String identificationNumber;
  String phoneNumber;
  String? telephone;
  String birthday;
  String gender;
  String address;

  ProfilePerson({
    this.id,
    required this.firstName,
    this.secondName,
    required this.surname,
    this.secondSurname,
    this.image,
    required this.username,
    required this.email,
    required this.identificationNumber,
    required this.phoneNumber,
    this.telephone,
    required this.birthday,
    required this.gender,
    required this.address,
  });
}
