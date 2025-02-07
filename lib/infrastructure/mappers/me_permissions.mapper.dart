import 'package:hope_app/domain/domain.dart';

class MePermissionsMapper {
  static Me mePermissionsJsonToEntity(
    Map<String, dynamic> json,
  ) =>
      Me(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        profile: fromJsonProfile(json["profile"]),
        roles:
            List<Role>.from((json["roles"] ?? []).map((x) => roleFromJson(x))),
      );

  static Role roleFromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        permissions: List<Permission>.from(
            (json["permissions"] ?? []).map((x) => permissionFromJson(x))),
      );

  static Permission permissionFromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        description: json["description"],
        status: json["status"],
      );

  static Profile fromJsonProfile(Map<String, dynamic> json) => Profile(
        profileId: json["profileId"],
        firstName: json["firstName"],
        secondName: json["secondName"],
        surname: json["surname"],
        secondSurname: json["secondSurname"],
        image: json["image"],
        identificationNumber: json["identificationNumber"],
        phoneNumber: json["phoneNumber"],
        telephone: json["telephone"],
        address: json["address"],
        birthday: json["birthday"],
        gender: json["gender"],
      );

  static Map<String, dynamic> toJsonProfile(Profile profile) => {
        "profileId": profile.profileId,
        "firstName": profile.firstName,
        "secondName": profile.secondName,
        "surname": profile.surname,
        "secondSurname": profile.secondSurname,
        "image": profile.image,
        "identificationNumber": profile.identificationNumber,
        "phoneNumber": profile.phoneNumber,
        "telephone": profile.telephone,
        "address": profile.address,
        "birthday": profile.birthday,
        "gender": profile.gender,
      };
}
