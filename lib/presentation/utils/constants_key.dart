//KEYS STORAGE
const String $token = "token";
const String $refreshToken = "refreshToken";
const String $permissions = "permissions";
const String $userName = "userName";
const String $email = "email";
const String $profile = "profile";
const String $verified = "verified";
const String $roles = "roles";

//KEYS PROFILE
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

const String $masculino = "Masculino";
const String $femenino = "Femenino";

//KEYS ACTIVITY
const String $name = "name";
const String $description = "description";
const String $satisfactoryPoints = "satisfactoryPoints";
const String $phaseId = "phaseId";
const String $pictogramSentence = "pictogramSentence";
const String $activityId = "activityId";
const String $patients = "patients";
const String $patientIdActivity = "patientId";

//KEYS CHILD
const String $patientId = "patientId";
const String $descriptionChild = "description";

//KEYS AUTH
const String $emailUsername = "email_username";
const String $password = "password";
const String $newPassword = "newPassword";
const String $confirmNewPassword = "confirmNewPassword";

//KEYS PAGINATE
const String $indexPage = "indexPage";
const String $pageCount = "pageCount";

//KEYS ROUTE
const String $childrenTherapist = "childrenTherapist";
const String $childrenTutor = "childrenTutor";
const String $activities = "activities";
const String $profileRoute = "profile";
const String $child = "child";
const String $idChild = "idChild";
const String $pictogram = "pictogram";
const String $customPictogram = "customPictogram";
const String $deleteActivity = "deleteActivity";
const String $idActivity = "idActivity";
const String $activity = "activity";
const String $isEdit = "isEdit";
const String $addActivity = "addActivity";
const String $removeActivity = "removeActivity";
const String $board = "board";
const String $dashboard = "dashboard";
const String $resetpassword = "resetpassword";
const String $login = "login";
const String $splash = "splash";
const String $newActivity = "newActivity";
const String $isTutor = "isTutor";

//FINALS REGEX
final $emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
final $regexphoneNumber = RegExp(r'^(5|7|8)[0-9]{7}$');
final $regexTelephone = RegExp(r'^(2)[0-9]{7}$');
final $regexPassword = RegExp(r'^[a-zA-z0-9]{8,30}$');
final $regexidentificationNumber = RegExp(
    r'^[0-9]{3}-(0[1-9]|[12][0-9]|3[01])(0[1-9]|1[012])([0-9]{2})-[0-9]{4}[^iIñÑzZ]+$');
