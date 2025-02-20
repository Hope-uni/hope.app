import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(
      storageProfile: KeyValueStorageRepositoryImpl(),
      profileRepository: ProfilePersonRepositoryImpl());
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  final KeyValueStorageRepositoryImpl storageProfile;
  final ProfilePersonRepositoryImpl profileRepository;

  ProfileNotifier(
      {required this.storageProfile, required this.profileRepository})
      : super(ProfileState());

  ProfilePerson _convertProfilePerson() {
    final ProfilePerson profilePerson = ProfilePerson(
      id: state.profile!.profileId,
      secondName: state.profile!.secondName ?? '',
      address: state.profile!.address,
      firstName: state.profile!.firstName,
      secondSurname: state.profile!.secondSurname ?? '',
      image: state.profile!.image ?? '',
      identificationNumber: state.profile!.identificationNumber,
      username: state.userName!,
      email: state.email!,
      birthday: state.profile!.birthday,
      telephone: state.profile!.telephone ?? '',
      gender: state.profile!.gender,
      phoneNumber: state.profile!.phoneNumber,
      activities: [],
      surname: state.profile!.surname,
      patients: [],
    );

    return profilePerson;
  }

  void _convertProfile(ProfilePerson profile) {
    state = state.copyWith(
      userName: profile.username,
      email: profile.email,
      profile: Profile(
        profileId: profile.id,
        fullName:
            '${profile.firstName} ${profile.secondName ?? ''} ${profile.surname} ${profile.secondSurname ?? ''}',
        firstName: profile.firstName,
        secondName: profile.secondName,
        surname: profile.surname,
        secondSurname: profile.secondSurname,
        image: profile.image,
        identificationNumber: profile.identificationNumber,
        phoneNumber: profile.phoneNumber,
        telephone: profile.telephone,
        address: profile.address,
        birthday: profile.birthday,
        gender: profile.gender,
      ),
    );
  }

  Future<bool> updateTherapist() async {
    try {
      final profilePerson = _convertProfilePerson();
      final response =
          await profileRepository.updateProfileTherapist(profilePerson);

      _convertProfile(response.data!);
      _updateProfileStorage(response.data!);

      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessageApi: S.current.Error_inesperado);
      return false;
    }
  }

  Future<bool> updateTutor() async {
    try {
      final profilePerson = _convertProfilePerson();
      final response =
          await profileRepository.updateProfileTutor(profilePerson);

      _convertProfile(response.data!);
      _updateProfileStorage(response.data!);

      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessageApi: S.current.Error_inesperado);
      return false;
    }
  }

  Future<void> _updateProfileStorage(ProfilePerson profilePerson) async {
    await storageProfile.setValueStorage<String>(
        profilePerson.username, S.current.User_Name);

    await storageProfile.setValueStorage<String>(
        profilePerson.email, S.current.Correo);

    await storageProfile.setValueStorage<String>(
        jsonEncode(MePermissionsMapper.toJsonProfile(
          Profile(
            profileId: profilePerson.id,
            fullName: profilePerson.firstName +
                (profilePerson.secondName ?? '') +
                profilePerson.surname +
                (profilePerson.secondSurname ?? ''),
            firstName: profilePerson.firstName,
            secondName: profilePerson.secondName,
            surname: profilePerson.surname,
            secondSurname: profilePerson.secondSurname,
            image: profilePerson.image,
            identificationNumber: profilePerson.identificationNumber,
            phoneNumber: profilePerson.phoneNumber,
            telephone: profilePerson.telephone,
            address: profilePerson.address,
            birthday: profilePerson.birthday,
            gender: profilePerson.gender,
          ),
        )),
        S.current.Profile);
  }

  Future<void> loadProfileAndPermmisions() async {
    final storedPermissions = await storageProfile
            .getValueStorage<List<String>>(S.current.Permisos) ??
        [];

    final storedProfile =
        await storageProfile.getValueStorage<String>(S.current.Profile);

    final storedUserName =
        await storageProfile.getValueStorage<String>(S.current.User_Name);

    final storedEmail =
        await storageProfile.getValueStorage<String>(S.current.Correo);

    final storedRoles =
        await storageProfile.getValueStorage<List<String>>('roles');

    state = state.copyWith(
        roles: storedRoles,
        userName: storedUserName,
        email: storedEmail,
        permmisions: storedPermissions,
        profile: storedProfile != null
            ? MePermissionsMapper.fromJsonProfile(jsonDecode(storedProfile))
            : null,
        isLoading: false);
  }

  void updateIsLoading() {
    state = state.copyWith(isLoading: false);
  }

  void resetProfile() {
    state = ProfileState();
  }

  void updateBirthday(DateTime newDate) {
    if (state.profile == null) return; // Evita errores si profile es null
    state.profile!.birthday = "${newDate.year}-${newDate.month}-${newDate.day}";
  }

  void updateProfileField(String fieldName, String newValue) {
// Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    Profile updatedProfile = state.profile!;
    switch (fieldName) {
      case "firstName":
        if (newValue.isNotEmpty) newValidationErrors.remove('firstName');
        updatedProfile = state.profile!.copyWith(firstName: newValue);
        break;
      case "secondName":
        updatedProfile = state.profile!.copyWith(secondName: newValue);
        break;
      case "surname":
        if (newValue.isNotEmpty) newValidationErrors.remove('surname');
        updatedProfile = state.profile!.copyWith(surname: newValue);
        break;
      case "secondSurname":
        updatedProfile = state.profile!.copyWith(secondSurname: newValue);
        break;
      case "identificationNumber":
        if (newValue.isNotEmpty) {
          newValidationErrors.remove('identificationNumber');
        }
        updatedProfile =
            state.profile!.copyWith(identificationNumber: newValue);
        break;
      case "address":
        if (newValue.isNotEmpty) newValidationErrors.remove('address');
        updatedProfile = state.profile!.copyWith(address: newValue);
        break;
      case "birthday":
        if (newValue.isNotEmpty) newValidationErrors.remove('birthday');
        updatedProfile = state.profile!.copyWith(birthday: newValue);
        break;
      case "telephone":
        final regexTelephone = RegExp(r'^(2)[0-9]{7}$');
        if (state.profile!.telephone != null &&
            regexTelephone.hasMatch(newValue)) {
          newValidationErrors.remove('telephone');
        }

        updatedProfile = state.profile!.copyWith(telephone: newValue);
        break;
      case "phoneNumber":
        final regexCel = RegExp(r'^(5|7|8)[0-9]{7}$');

        if (regexCel.hasMatch(newValue)) {
          newValidationErrors.remove('phoneNumber');
        }
        updatedProfile = state.profile!.copyWith(phoneNumber: newValue);
        break;
      case "image":
        updatedProfile = state.profile!.copyWith(image: newValue);
        break;
      case "gender":
        if (newValue.isNotEmpty) newValidationErrors.remove('gender');
        updatedProfile = state.profile!.copyWith(gender: newValue);
        break;
      default:
        break;
    }

    state = state.copyWith(
      profile: updatedProfile,
      validationErrors: newValidationErrors,
    );
  }

  void updateUserName(String value) {
// Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    if (value.isNotEmpty) newValidationErrors.remove('userName');

    state = state.copyWith(
      userName: value,
      validationErrors: newValidationErrors,
    );
  }

  void updateEmail(String value) {
    // Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    if (value.isNotEmpty) newValidationErrors.remove('email');
    state = state.copyWith(
      email: value,
      validationErrors: newValidationErrors,
    );
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.userName == null || state.userName!.isEmpty) {
      errors['userName'] = "El nombre de usuario no puede estar vacio";
    }
    if (state.email == null || state.email!.isEmpty) {
      errors['email'] = "El  correo no puede estar vacio";
    }
    if (state.profile!.firstName.isEmpty) {
      errors['firstName'] = "El primer nombre no puede estar vacio";
    }
    if (state.profile!.surname.isEmpty) {
      errors['surname'] = "El primer apellido no puede estar vacio";
    }
    if (state.profile!.address.isEmpty) {
      errors['address'] = "La direccion no puede estar vacia";
    }
    if (state.profile!.birthday.isEmpty) {
      errors['birthday'] = "La fecha de nacimiento no puede estar vacia";
    }
    if (state.profile!.gender.isEmpty) {
      errors['gender'] = "El sexo no puede estar vacio";
    }

    final regexCedula = RegExp(
        r'^[0-9]{3}-(0[1-9]|[12][0-9]|3[01])(0[1-9]|1[012])([0-9]{2})-[0-9]{4}[^iIñÑzZ]+$');

    if (!regexCedula.hasMatch(state.profile!.identificationNumber)) {
      errors['identificationNumber'] =
          'Formato incorrecto de cédula (###-######-####L)';
    }

    if (state.profile!.identificationNumber.isEmpty) {
      errors['identificationNumber'] = "La cedula no puede estar vacia";
    }

    final regexCel = RegExp(r'^(5|7|8)[0-9]{7}$');

    if (!regexCel.hasMatch(state.profile!.phoneNumber)) {
      errors['phoneNumber'] =
          "El celular deber ser un numero valido y no estar vacio";
    }

    final regexTelephone = RegExp(r'^(2)[0-9]{7}$');
    if (state.profile!.telephone != null &&
        !regexTelephone.hasMatch(state.profile!.telephone!)) {
      errors['telephone'] =
          "El telefono deber ser un numero valido y no estar vacio";
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

class ProfileState {
  final List<String>? roles;
  final Profile? profile;
  final String? userName;
  final String? email;
  final List<String>? permmisions;
  final bool isLoading;
  final String? errorMessageApi;
  final Map<String, String?> validationErrors;

  ProfileState({
    this.roles,
    this.profile,
    this.userName,
    this.email,
    this.permmisions,
    this.isLoading = true,
    this.errorMessageApi,
    this.validationErrors = const {},
  });

  ProfileState copyWith({
    List<String>? roles,
    Profile? profile,
    String? userName,
    String? email,
    bool? isLoading,
    String? errorMessageApi,
    Map<String, String?>? validationErrors,
    List<String>? permmisions,
  }) =>
      ProfileState(
        roles: roles ?? this.roles,
        profile: profile ?? this.profile,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        isLoading: isLoading ?? this.isLoading,
        errorMessageApi: errorMessageApi ?? this.errorMessageApi,
        validationErrors: validationErrors ?? this.validationErrors,
        permmisions: permmisions ?? this.permmisions,
      );
}
