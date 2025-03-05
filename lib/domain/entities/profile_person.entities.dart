import 'package:hope_app/domain/domain.dart';

class ProfilePerson extends Person {
  int? id;
  String identificationNumber;
  String phoneNumber;
  String? telephone;

  ProfilePerson({
    this.id,
    required super.firstName,
    super.secondName,
    required super.surname,
    super.secondSurname,
    super.image,
    required super.username,
    required super.email,
    required this.identificationNumber,
    required this.phoneNumber,
    this.telephone,
    required super.birthday,
    required super.gender,
    required super.address,
  });
}
