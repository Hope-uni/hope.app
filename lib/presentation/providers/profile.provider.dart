import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:intl/intl.dart';

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(
      storageProfile: KeyValueStorageRepositoryImpl(),
      profileRepository: ProfilePersonRepositoryImpl());
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  final KeyValueStorageRepositoryImpl storageProfile;
  final ProfilePersonRepositoryImpl profileRepository;

  ProfileState? originalState;

  ProfileNotifier({
    required this.storageProfile,
    required this.profileRepository,
  }) : super(ProfileState());

  ProfilePerson _convertProfilePerson() {
    final ProfilePerson profilePerson = ProfilePerson(
      secondName: state.profile!.secondName ?? '',
      address: state.profile!.address,
      firstName: state.profile!.firstName,
      secondSurname: state.profile!.secondSurname ?? '',
      identificationNumber: state.profile!.identificationNumber ?? '',
      username: state.userName!,
      email: state.email!,
      birthday: state.profile!.birthday,
      telephone: state.profile!.telephone ?? '',
      gender: state.profile!.gender,
      phoneNumber: state.profile!.phoneNumber ?? '',
      surname: state.profile!.surname,
      imageUrl: state.profile!.imageUrl,
    );

    return profilePerson;
  }

  void _convertProfile({required ProfilePerson profile}) {
    state = state.copyWith(
      userName: profile.username,
      email: profile.email,
      profile: Profile(
        profileId: profile.id!,
        fullName:
            '${profile.firstName} ${profile.secondName ?? ''} ${profile.surname} ${profile.secondSurname ?? ''}',
        firstName: profile.firstName,
        secondName: profile.secondName,
        surname: profile.surname,
        secondSurname: profile.secondSurname,
        identificationNumber: profile.identificationNumber,
        phoneNumber: profile.phoneNumber,
        telephone: profile.telephone,
        address: profile.address,
        birthday: profile.birthday,
        gender: profile.gender,
        imageUrl: profile.imageUrl,
      ),
    );
  }

  Future<void> updateTherapist() async {
    state = state.copyWith(isUpdateData: true);
    try {
      final profilePerson = _convertProfilePerson();
      final response = await profileRepository.updateProfileTherapist(
        profilePerson: profilePerson,
        idTherapist: state.profile!.profileId,
      );

      _convertProfile(profile: response.data!);
      _updateProfileStorage(profilePerson: response.data!);

      originalState = null;
      state = state.copyWith(isUpdateData: false, showtoastAlert: true);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isUpdateData: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isUpdateData: false,
      );
    }
  }

  Future<void> updateTutor() async {
    state = state.copyWith(isUpdateData: true);
    try {
      final profilePerson = _convertProfilePerson();
      final response = await profileRepository.updateProfileTutor(
        profilePerson: profilePerson,
        idTutor: state.profile!.profileId,
      );

      _convertProfile(profile: response.data!);
      _updateProfileStorage(profilePerson: response.data!);

      originalState = null;
      state = state.copyWith(isUpdateData: false, showtoastAlert: true);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isUpdateData: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isUpdateData: false,
      );
    }
  }

  Future<void> _updateProfileStorage({
    required ProfilePerson profilePerson,
  }) async {
    await storageProfile.setValueStorage<String>(
      profilePerson.username,
      $userName,
    );

    await storageProfile.setValueStorage<String>(profilePerson.email, $email);

    await storageProfile.setValueStorage<String>(
      jsonEncode(MePermissionsMapper.toJsonProfile(
        Profile(
          profileId: profilePerson.id!,
          fullName: profilePerson.firstName +
              (profilePerson.secondName ?? '') +
              profilePerson.surname +
              (profilePerson.secondSurname ?? ''),
          firstName: profilePerson.firstName,
          secondName: profilePerson.secondName,
          surname: profilePerson.surname,
          secondSurname: profilePerson.secondSurname,
          identificationNumber: profilePerson.identificationNumber,
          phoneNumber: profilePerson.phoneNumber,
          telephone: profilePerson.telephone,
          address: profilePerson.address,
          birthday: profilePerson.birthday,
          gender: profilePerson.gender,
          imageUrl: profilePerson.imageUrl,
        ),
      )),
      $profile,
    );
  }

  Future<void> loadProfileAndPermmisions() async {
    final storedPermissions =
        await storageProfile.getValueStorage<List<String>>($permissions) ?? [];

    final storedProfile =
        await storageProfile.getValueStorage<String>($profile);

    final storedUserName =
        await storageProfile.getValueStorage<String>($userName);

    final storedEmail = await storageProfile.getValueStorage<String>($email);

    final storedRoles =
        await storageProfile.getValueStorage<List<String>>($roles);

    state = state.copyWith(
      roles: storedRoles,
      userName: storedUserName,
      email: storedEmail,
      permmisions: storedPermissions,
      profile: storedProfile != null
          ? MePermissionsMapper.fromJsonProfile(jsonDecode(storedProfile))
          : null,
      isLoading: false,
    );
  }

  void updateIsLoading({required bool isLoading}) {
    state = state.copyWith(isLoading: isLoading);
  }

  void updateBirthday({required DateTime newDate}) {
    if (state.profile == null) return; // Evita errores si profile es null
    String dateFormat = DateFormat('yyyy-MM-dd').format(newDate);
    state.profile!.birthday = dateFormat;
  }

  void updateProfileField({
    required String fieldName,
    required String newValue,
  }) {
    //Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    Profile updatedProfile = state.profile!;
    switch (fieldName) {
      case $firstNameProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($firstNameProfile);
        updatedProfile = state.profile!.copyWith(firstName: newValue);
        break;

      case $secondNameProfile:
        updatedProfile = state.profile!.copyWith(secondName: newValue);
        break;

      case $surnameProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($surnameProfile);
        updatedProfile = state.profile!.copyWith(surname: newValue);
        break;

      case $secondSurnameProfile:
        updatedProfile = state.profile!.copyWith(secondSurname: newValue);
        break;

      case $identificationNumbereProfile:
        if ($regexidentificationNumber.hasMatch(newValue)) {
          newValidationErrors.remove($identificationNumbereProfile);
        }
        updatedProfile =
            state.profile!.copyWith(identificationNumber: newValue);
        break;

      case $addressProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($addressProfile);
        updatedProfile = state.profile!.copyWith(address: newValue);
        break;

      case $birthdayProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($birthdayProfile);
        updatedProfile = state.profile!.copyWith(birthday: newValue);
        break;

      case $telephoneProfile:
        if ($regexTelephone.hasMatch(newValue)) {
          newValidationErrors.remove($telephoneProfile);
        }

        updatedProfile = state.profile!.copyWith(telephone: newValue);
        break;

      case $phoneNumberProfile:
        if ($regexphoneNumber.hasMatch(newValue)) {
          newValidationErrors.remove($phoneNumberProfile);
        }
        updatedProfile = state.profile!.copyWith(phoneNumber: newValue);
        break;

      case $imageProfile:
        updatedProfile = state.profile!.copyWith(imageUrl: newValue);
        break;

      case $genderProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($genderProfile);
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

  void updateUserName({required String value}) {
    // Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    if (value.isNotEmpty) newValidationErrors.remove($userNameProfile);

    state = state.copyWith(
      userName: value,
      validationErrors: newValidationErrors,
    );
  }

  void updateEmail({required String value}) {
    // Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    if (value.isNotEmpty) newValidationErrors.remove($emailProfile);
    state = state.copyWith(
      email: value,
      validationErrors: newValidationErrors,
    );
  }

  void updateResponse() {
    state = state.copyWith(errorMessageApi: '', showtoastAlert: false);
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.userName == null || state.userName!.isEmpty) {
      errors[$userNameProfile] =
          S.current.El_nombre_de_usuario_no_puede_estar_vacio;
    } else {
      if (state.userName!.length <= 2 || state.userName!.length >= 16) {
        errors[$userNameProfile] = S.current
            .El_nombre_del_usuario_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres;
      }
    }

    if (state.email == null || state.email!.isEmpty) {
      errors[$emailProfile] = S.current.El_correo_no_puede_estar_vacio;
    } else {
      if (!$emailRegex.hasMatch(state.email!)) {
        errors[$emailProfile] =
            S.current.Formato_incorrecto_de_correo_electronico;
      }
    }

    if (state.profile!.firstName.isEmpty) {
      errors[$firstNameProfile] =
          S.current.El_primer_nombre_no_puede_estar_vacio;
    } else {
      if (state.profile!.firstName.length <= 2 ||
          state.profile!.firstName.length >= 16) {
        errors[$firstNameProfile] = S.current
            .El_primer_nombre_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres;
      }
    }

    if (state.profile!.surname.isEmpty) {
      errors[$surnameProfile] =
          S.current.El_primer_apellido_no_puede_estar_vacio;
    } else {
      if (state.profile!.surname.length <= 2 ||
          state.profile!.surname.length >= 16) {
        errors[$surnameProfile] = S.current
            .El_primer_apellido_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres;
      }
    }

    if (state.profile!.address.isEmpty) {
      errors[$addressProfile] = S.current.La_direccion_no_puede_estar_vacia;
    } else {
      if (state.profile!.address.length <= 5 ||
          state.profile!.address.length >= 255) {
        errors[$addressProfile] = S.current
            .La_direccion_no_puede_ser_menor_a_seis_o_mayor_a_docientocincuentaycinco_caracteres;
      }
    }

    if (state.profile!.birthday.isEmpty) {
      errors[$birthdayProfile] =
          S.current.La_fecha_de_nacimiento_no_puede_estar_vacia;
    }
    if (state.profile!.gender.isEmpty) {
      errors[$genderProfile] = S.current.El_sexo_no_puede_estar_vacio;
    }

    if (!$regexidentificationNumber
        .hasMatch(state.profile!.identificationNumber!)) {
      errors[$identificationNumbereProfile] =
          S.current.Formato_incorrecto_de_cedula;
    }

    if (!$regexphoneNumber.hasMatch(state.profile!.phoneNumber!)) {
      errors[$phoneNumberProfile] =
          S.current.El_celular_deber_ser_un_numero_valido_y_no_estar_vacio;
    }

    if (state.profile!.telephone != null &&
        !$regexTelephone.hasMatch(state.profile!.telephone!)) {
      errors[$telephoneProfile] =
          S.current.El_telefono_deber_ser_un_numero_valido_y_no_estar_vacio;
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void restoredState() {
    if (originalState != null) {
      state = originalState!;
      originalState = null;
    }
  }

  void assingState() {
    originalState = state;
  }

  void resetProfile() => state = ProfileState();
}

class ProfileState {
  final List<String>? roles;
  final Profile? profile;
  final String? userName;
  final String? email;
  final List<String>? permmisions;
  final bool isLoading;
  final bool? isUpdateData;
  final bool? showtoastAlert;
  final String? errorMessageApi;
  final Map<String, String?> validationErrors;

  ProfileState({
    this.roles,
    this.profile,
    this.userName,
    this.email,
    this.permmisions,
    this.isLoading = true,
    this.isUpdateData,
    this.showtoastAlert = false,
    this.errorMessageApi,
    this.validationErrors = const {},
  });

  ProfileState copyWith({
    List<String>? roles,
    Profile? profile,
    String? userName,
    String? email,
    bool? isLoading,
    bool? isUpdateData,
    bool? showtoastAlert,
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
        isUpdateData: isUpdateData ?? this.isUpdateData,
        showtoastAlert: showtoastAlert ?? this.showtoastAlert,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        validationErrors: validationErrors ?? this.validationErrors,
        permmisions: permmisions ?? this.permmisions,
      );
}
