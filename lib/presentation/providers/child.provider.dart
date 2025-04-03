import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:intl/intl.dart';

final childProvider =
    StateNotifierProvider.autoDispose<ChildNotifier, ChildState>((ref) {
  return ChildNotifier(childrenRepository: ChildrenRepositoryImpl());
});

class ChildNotifier extends StateNotifier<ChildState> {
  final ChildrenRepositoryImpl childrenRepository;

  ChildState? originalState;

  ChildNotifier({required this.childrenRepository}) : super(ChildState());

  Future<void> getChild({required int idChild}) async {
    state = state.copyWith(isLoading: true);
    try {
      final responseChild = await childrenRepository.getChild(idChild: idChild);
      state = state.copyWith(
        child: responseChild.data,
        isLoading: false,
        isError: false,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessageApi: e.message,
        isLoading: false,
        isError: true,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
        isError: true,
      );
    }
  }

  Person _jsonPerson() {
    final Person person = Person(
      firstName: state.child!.firstName,
      surname: state.child!.surname,
      gender: state.child!.gender,
      username: state.child!.username,
      email: state.child!.email,
      birthday: state.child!.birthday,
      address: state.child!.address,
      image: state.child!.image,
      secondName: state.child!.secondName,
      secondSurname: state.child!.secondSurname,
    );

    return person;
  }

  Future<void> updateChild() async {
    state = state.copyWith(isUpdateData: true);
    try {
      final responseChild = await childrenRepository.updateChild(
          idChild: state.child!.id, child: _jsonPerson());

      final child = state.child!.copyWith(
        address: responseChild.data!.address,
        birthday: responseChild.data!.birthday,
        email: responseChild.data!.email,
        firstName: responseChild.data!.firstName,
        gender: responseChild.data!.gender,
        image: responseChild.data!.image,
        secondName: responseChild.data!.secondName,
        secondSurname: responseChild.data!.secondSurname,
        surname: responseChild.data!.surname,
        username: responseChild.data!.username,
      );

      originalState = null;

      state = state.copyWith(
        child: child,
        isUpdateData: false,
        isComplete: true,
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isUpdateData: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isUpdateData: false,
      );
    }
  }

  Future<void> updateMonochrome({required int idChild}) async {
    state = state.copyWith(isUpdateData: true);
    try {
      final responseMonochrome =
          await childrenRepository.updateMonochrome(idChild: idChild);

      Child updatedChild = state.child!;

      updatedChild = state.child!.copyWith(
        isMonochrome: responseMonochrome.data!.isMonochrome,
      );

      state = state.copyWith(
        child: updatedChild,
        isUpdateData: false,
        isUpdateMonochrome: true,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessageApi: e.message,
        isLoading: false,
        isError: true,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
        isError: true,
      );
    }
  }

  void updateChildField({required String fieldName, required String newValue}) {
    //Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    Child updatedChild = state.child!;
    switch (fieldName) {
      case $userNameProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($userNameProfile);
        updatedChild = state.child!.copyWith(username: newValue);
        break;

      case $emailProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($emailProfile);
        updatedChild = state.child!.copyWith(email: newValue);
        break;

      case $firstNameProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($firstNameProfile);
        updatedChild = state.child!.copyWith(firstName: newValue);
        break;

      case $secondNameProfile:
        updatedChild = state.child!.copyWith(secondName: newValue);
        break;

      case $surnameProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($surnameProfile);
        updatedChild = state.child!.copyWith(surname: newValue);
        break;

      case $secondSurnameProfile:
        updatedChild = state.child!.copyWith(secondSurname: newValue);
        break;

      case $addressProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($addressProfile);
        updatedChild = state.child!.copyWith(address: newValue);
        break;

      case $birthdayProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($birthdayProfile);
        updatedChild = state.child!.copyWith(birthday: newValue);
        break;

      case $imageProfile:
        updatedChild = state.child!.copyWith(image: newValue);
        break;

      case $genderProfile:
        if (newValue.isNotEmpty) newValidationErrors.remove($genderProfile);
        updatedChild = state.child!.copyWith(gender: newValue);
        break;

      default:
        break;
    }

    state = state.copyWith(
      child: updatedChild,
      validationErrors: newValidationErrors,
    );
  }

  void updateObservations({required Observation newObservation}) {
    Child updatedChild = state.child!;

    updatedChild = state.child!.copyWith(
      observations: [newObservation, ...state.child!.observations ?? []],
    );

    state = state.copyWith(child: updatedChild);
  }

  void updateProgress({required PhaseShift newPhase}) {
    Child updatedChild = state.child!;

    updatedChild = state.child!.copyWith(
      currentPhase: newPhase.currentPhase,
      progress: newPhase.progress,
    );

    state = state.copyWith(child: updatedChild);
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.child!.username.isEmpty) {
      errors[$userNameProfile] =
          S.current.El_nombre_de_usuario_no_puede_estar_vacio;
    } else {
      if (state.child!.username.length <= 2 ||
          state.child!.username.length >= 16) {
        errors[$userNameProfile] = S.current
            .El_nombre_del_usuario_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres;
      }
    }
    if (state.child!.email.isEmpty) {
      errors[$emailProfile] = S.current.El_correo_no_puede_estar_vacio;
    }

    if (state.child!.firstName.isEmpty) {
      errors[$firstNameProfile] =
          S.current.El_primer_nombre_no_puede_estar_vacio;
    } else {
      if (state.child!.firstName.length <= 2 ||
          state.child!.firstName.length >= 16) {
        errors[$firstNameProfile] = S.current
            .El_primer_nombre_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres;
      }
    }

    if (state.child!.surname.isEmpty) {
      errors[$surnameProfile] =
          S.current.El_primer_apellido_no_puede_estar_vacio;
    } else {
      if (state.child!.surname.length <= 2 ||
          state.child!.surname.length >= 16) {
        errors[$surnameProfile] = S.current
            .El_primer_apellido_no_puede_ser_menor_a_tres_o_mayor_a_quince_caracteres;
      }
    }

    if (state.child!.address.isEmpty) {
      errors[$addressProfile] = S.current.La_direccion_no_puede_estar_vacia;
    } else {
      if (state.child!.address.length <= 5 ||
          state.child!.address.length >= 255) {
        errors[$addressProfile] = S.current
            .La_direccion_no_puede_ser_menor_a_seis_o_mayor_a_docientocincuentaycinco_caracteres;
      }
    }

    if (state.child!.birthday.isEmpty) {
      errors[$birthdayProfile] =
          S.current.La_fecha_de_nacimiento_no_puede_estar_vacia;
    }
    if (state.child!.gender.isEmpty) {
      errors[$genderProfile] = S.current.El_sexo_no_puede_estar_vacio;
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateBirthday({required DateTime newDate}) {
    if (state.child == null) return; // Evita errores si profile es null
    String dateFormat = DateFormat('yyyy-MM-dd').format(newDate);
    state.child!.birthday = dateFormat;
    state = state;
  }

  void updateResponse() {
    state = state.copyWith(
      errorMessageApi: '',
      isComplete: false,
      isUpdateMonochrome: false,
    );
  }

  void resetChild() => state = ChildState();

  void restoredState() {
    if (originalState != null) {
      state = originalState!;
      originalState = null;
    }
  }

  void assingState() => originalState = state;
}

class ChildState {
  final Child? child;
  final bool isLoading;
  final bool isUpdateData;
  final bool isComplete;
  final bool isUpdateMonochrome;
  final bool? isError;
  final String? errorMessageApi;
  final Map<String, String?> validationErrors;

  ChildState({
    this.child,
    this.isLoading = false,
    this.isUpdateData = false,
    this.isComplete = false,
    this.isUpdateMonochrome = false,
    this.isError,
    this.errorMessageApi,
    this.validationErrors = const {},
  });

  ChildState copyWith({
    Child? child,
    bool? isLoading,
    bool? isUpdateData,
    bool? isComplete,
    bool? isUpdateMonochrome,
    bool? isError,
    Map<String, String?>? validationErrors,
    String? errorMessageApi,
  }) =>
      ChildState(
        child: child ?? this.child,
        isLoading: isLoading ?? this.isLoading,
        isUpdateData: isUpdateData ?? this.isUpdateData,
        isError: isError ?? this.isError,
        isUpdateMonochrome: isUpdateMonochrome ?? this.isUpdateMonochrome,
        validationErrors: validationErrors ?? this.validationErrors,
        isComplete: isComplete ?? this.isComplete,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
      );
}
