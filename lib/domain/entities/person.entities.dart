class Person {
  String firstName;
  String? secondName;
  String surname;
  String? secondSurname;
  String gender;
  String? imageUrl;
  String username;
  String email;
  String birthday;
  int age;
  String address;

  Person({
    required this.firstName,
    this.secondName,
    required this.surname,
    this.secondSurname,
    required this.gender,
    this.imageUrl,
    required this.username,
    required this.email,
    required this.birthday,
    required this.age,
    required this.address,
  });
}
