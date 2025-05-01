import 'package:hope_app/domain/domain.dart';

class ProfilePersonMapper {
  static ProfilePerson profilePersonJsonToEntity(
    Map<String, dynamic> json,
  ) =>
      ProfilePerson(
        id: json["id"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        surname: json["surname"],
        secondSurname: json["secondSurname"],
        username: json["username"],
        email: json["email"],
        identificationNumber: json["identificationNumber"],
        phoneNumber: json["phoneNumber"],
        telephone: json["telephone"],
        birthday: json["birthday"],
        gender: json["gender"],
        address: json["address"],
      );

  static Map<String, dynamic> toJson(ProfilePerson profile) => {
        "id": profile.id,
        "firstName": profile.firstName,
        "secondName": profile.secondName,
        "surname": profile.surname,
        "secondSurname": profile.secondSurname,
        "username": profile.username,
        "email": profile.email,
        "identificationNumber": profile.identificationNumber,
        "phoneNumber": profile.phoneNumber,
        "gender": profile.gender,
        "address": profile.address,
        "birthday": profile.birthday,
      };

  static Map<String, dynamic> toJsonPatients(patients) => {
        "userId": patients.userId,
        "id": patients.id,
        "fullName": patients.fullName,
        "age": patients.age,
      };
}
