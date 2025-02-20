import 'package:hope_app/domain/domain.dart';

class ProfilePerson {
  int id;
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
  List<Patient> patients;
  List<dynamic> activities; //TODO: Cambiar cuando mapee actividades

  ProfilePerson({
    required this.id,
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
    required this.patients,
    required this.activities,
  });
}
