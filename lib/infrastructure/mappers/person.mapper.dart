import 'package:hope_app/domain/domain.dart';

class PersonMapper {
  static Person personFromJson(Map<String, dynamic> json) => Person(
        firstName: json["firstName"],
        secondName: json["secondName"],
        surname: json["surname"],
        secondSurname: json["secondSurname"],
        gender: json["gender"],
        imageUrl: json["image"],
        username: json["username"],
        email: json["email"],
        birthday: json["birthday"],
        address: json["address"],
      );

  static Map<String, dynamic> personToJson(Person person) => {
        "firstName": person.firstName,
        "secondName": person.secondName,
        "surname": person.surname,
        "secondSurname": person.secondSurname,
        "gender": person.gender,
        "image": person.imageUrl,
        "username": person.username,
        "email": person.email,
        "birthday": person.birthday,
        "address": person.address,
      };
}
