import 'package:hope_app/domain/domain.dart';

class ProfilePerson extends Person {
  int? id;
  String? identificationNumber;
  String? phoneNumber;
  String? telephone;

  ProfilePerson({
    this.id,
    super.secondName,
    super.secondSurname,
    super.image,
    this.identificationNumber,
    this.phoneNumber,
    this.telephone,
    required super.surname,
    required super.username,
    required super.email,
    required super.firstName,
    required super.birthday,
    required super.gender,
    required super.address,
  });
}
