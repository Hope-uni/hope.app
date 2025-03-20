import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final customPictogramProvider =
    StateNotifierProvider<CustomPictogramNotifier, CustomPictogramState>((ref) {
  return CustomPictogramNotifier(
      pictogramsRepository: PictogramsRepositoyImpl());
});

class CustomPictogramNotifier extends StateNotifier<CustomPictogramState> {
  final PictogramsRepositoyImpl pictogramsRepository;

  CustomPictogramNotifier({required this.pictogramsRepository})
      : super(CustomPictogramState());

  Future<bool> createCustomPictogram() async {
    state = state.copyWith(isLoading: true);
    try {
      final customPicto = setCustomPictogram();
      final response = await pictogramsRepository.createCustomPictogram(
        customPictogram: customPicto,
      );

      state = state.copyWith(
        isLoading: false,
        showtoastAlert: true,
        pictogram: response.data,
      );
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
      return false;
    } catch (e) {
      state = state.copyWith(
          errorMessageApi: S.current.Error_inesperado, isLoading: false);
      return false;
    }
  }

  CustomPictogram setCustomPictogram() {
    final customPictogram = CustomPictogram(
      imageUrl: state.pictogram!.imageUrl,
      name: state.pictogram!.name,
      patientId: state.idChild,
      pictogramId: state.pictogram!.id,
    );

    return customPictogram;
  }

  void loadCustomPictogram({required PictogramAchievements pictogram}) {
    state = state.copyWith(pictogram: pictogram);
  }

  void updateMessage() {
    state = state.copyWith(errorMessageApi: '', showtoastAlert: false);
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.pictogram!.name.isEmpty) {
      errors[$name] = S.current.El_nombre_del_pictograma_no_puede_estar_vacio;
    } else {
      if (state.pictogram!.name.length <= 2 ||
          state.pictogram!.name.length >= 61) {
        errors[$name] = S.current
            .El_nombre_no_puede_ser_menor_a_tres_o_mayor_a_sesenta_caracteres;
      }
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateName(String newValue) {
    //Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    PictogramAchievements customPictogram = state.pictogram!;

    if (newValue.isNotEmpty) newValidationErrors.remove($name);
    customPictogram = state.pictogram!.copyWith(name: newValue);

    state = state.copyWith(
      pictogram: customPictogram,
      validationErrors: newValidationErrors,
    );
  }

  void setIdChild({required int idChild}) {
    state = state.copyWith(idChild: idChild);
  }

  void resetState() {
    state = CustomPictogramState(idChild: state.idChild);
  }
}

class CustomPictogramState {
  final int idChild;
  final bool? isLoading;
  final String? errorMessageApi;
  final PictogramAchievements? pictogram;
  final Map<String, String?> validationErrors;
  final bool? showtoastAlert;

  CustomPictogramState({
    this.idChild = 0,
    this.isLoading,
    this.errorMessageApi,
    this.pictogram,
    this.showtoastAlert = false,
    this.validationErrors = const {},
  });

  CustomPictogramState copyWith({
    int? idChild,
    bool? isLoading,
    String? errorMessageApi,
    PictogramAchievements? pictogram,
    bool? showtoastAlert,
    Map<String, String?>? validationErrors,
  }) =>
      CustomPictogramState(
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        idChild: idChild ?? this.idChild,
        showtoastAlert: showtoastAlert ?? this.showtoastAlert,
        isLoading: isLoading ?? this.isLoading,
        pictogram: pictogram ?? this.pictogram,
        validationErrors: validationErrors ?? this.validationErrors,
      );
}
