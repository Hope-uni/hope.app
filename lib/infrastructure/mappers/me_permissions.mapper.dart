import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class MePermissionsMapper {
  static Me mePermissionsJsonToEntity(
    Map<String, dynamic> json,
  ) =>
      Me(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        userVerified: json["userVerified"],
        profile:
            json["profile"] == null ? null : fromJsonProfile(json["profile"]),
        roles: List<Role>.from(
            (json["roles"] ?? []).map((x) => RoleMapper.roleFromJson(x))),
      );

  static Profile fromJsonProfile(Map<String, dynamic> json) => Profile(
        profileId: json["profileId"],
        fullName: json["fullName"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        surname: json["surname"],
        secondSurname: json["secondSurname"],
        identificationNumber: json["identificationNumber"],
        phoneNumber: json["phoneNumber"],
        telephone: json["telephone"],
        address: json["address"],
        birthday: json["birthday"],
        age: json["age"],
        gender: json["gender"],
        imageUrl: json["imageUrl"],
        isMonochrome: json["isMonochrome"],
      );

  static Map<String, dynamic> toJsonProfile(Profile profile) => {
        "profileId": profile.profileId,
        "fullName": profile.fullName,
        "firstName": profile.firstName,
        "secondName": profile.secondName,
        "surname": profile.surname,
        "secondSurname": profile.secondSurname,
        "identificationNumber": profile.identificationNumber,
        "phoneNumber": profile.phoneNumber,
        "telephone": profile.telephone,
        "address": profile.address,
        "birthday": profile.birthday,
        "age": profile.age,
        "imageUrl": profile.imageUrl,
        "gender": profile.gender,
      };
}
