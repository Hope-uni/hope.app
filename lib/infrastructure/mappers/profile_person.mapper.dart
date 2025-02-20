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
          image: json["image"],
          username: json["username"],
          email: json["email"],
          identificationNumber: json["identificationNumber"],
          phoneNumber: json["phoneNumber"].toString(),
          telephone: json["telephone"],
          birthday: json["birthday"],
          gender: json["gender"],
          address: json["address"],
          patients: List<Patient>.from(
              (json["patients"] ?? []).map((x) => patientsFromJson(x))),
          activities: List<Patient>.from((json["patients"] ?? []).map((x) =>
              patientsFromJson(
                  x)))); //TODO: Cambiar cuando haga el mapeo de las actividades

  static Patient patientsFromJson(Map<String, dynamic> json) => Patient(
        id: json["id"].toString(),
        fullName: json["fullName"],
        fase: json["fase"] ?? '',
        edad: json["edad"].toString(),
      );

  static Map<String, dynamic> toJson(ProfilePerson profile) => {
        "id": profile.id,
        "firstName": profile.firstName,
        "secondName": profile.secondName,
        "surname": profile.surname,
        "secondSurname": profile.secondSurname,
        "image": profile.image,
        "username": profile.username,
        "email": profile.email,
        "identificationNumber": profile.identificationNumber,
        "phoneNumber": profile.phoneNumber,
        "gender": profile.gender,
        "address": profile.address,
        "patients":
            List<dynamic>.from(profile.patients.map((x) => toJsonPatients(x))),
      };

  static Map<String, dynamic> toJsonPatients(patients) => {
        "userId": patients.userId,
        "id": patients.id,
        "fullName": patients.fullName,
        "age": patients.age,
      };
}
