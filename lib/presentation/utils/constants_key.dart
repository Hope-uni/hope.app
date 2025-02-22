//Keys Storage
const String $token = "token";
const String $refreshToken = "refreshToken";
const String $permissions = "permissions";
const String $userName = "userName";
const String $email = "email";
const String $profile = "profile";
const String $verified = "verified";
const String $roles = "roles";

//Keys Profile
const String $userNameProfile = "userName";
const String $emailProfile = "email";
const String $firstNameProfile = "firstName";
const String $secondNameProfile = "secondName";
const String $surnameProfile = "surname";
const String $secondSurnameProfile = "secondSurname";
const String $identificationNumbereProfile = "identificationNumber";
const String $genderProfile = "gender";
const String $birthdayProfile = "birthday";
const String $phoneNumberProfile = "phoneNumber";
const String $telephoneProfile = "telephone";
const String $addressProfile = "address";
const String $imageProfile = "image";

const String $masculinoProfile = "Masculino";
const String $femeninoProfile = "Femenino";

//Finals REGEX

final $regexphoneNumber = RegExp(r'^(5|7|8)[0-9]{7}$');
final $regexTelephone = RegExp(r'^(2)[0-9]{7}$');
final $regexidentificationNumber = RegExp(
    r'^[0-9]{3}-(0[1-9]|[12][0-9]|3[01])(0[1-9]|1[012])([0-9]{2})-[0-9]{4}[^iIñÑzZ]+$');
