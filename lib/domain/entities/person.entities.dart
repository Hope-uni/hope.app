class Person {
  String firstName;
  String? secondName;
  String surname;
  String? secondSurname;
  String gender;
  String? image;
  String username;
  String email;
  String birthday;
  String address;

  Person({
    required this.firstName,
    this.secondName,
    required this.surname,
    this.secondSurname,
    required this.gender,
    this.image,
    required this.username,
    required this.email,
    required this.birthday,
    required this.address,
  });
}
