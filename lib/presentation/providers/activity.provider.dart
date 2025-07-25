import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final activityProvider =
    StateNotifierProvider.autoDispose<ActivityNotifier, ActivityState>((ref) {
  return ActivityNotifier(activityRepository: ActivitiesRepositoryImpl());
});

class ActivityNotifier extends StateNotifier<ActivityState> {
  final ActivitiesRepositoryImpl activityRepository;

  ActivityNotifier({required this.activityRepository})
      : super(
          ActivityState(
            activity: CreateActivity(
              name: '',
              description: '',
              satisfactoryPoints: 0,
              pictogramSentence: [],
              phaseId: 0,
            ),
          ),
        );

  Future<void> createActivity() async {
    state = state.copyWith(isLoading: true);
    try {
      final activityResponse =
          await activityRepository.createActivity(activity: state.activity!);

      state = state.copyWith(
        isLoading: false,
        showActivity: activityResponse.data,
        showtoastAlert: true,
        errorMessageApi: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
    }
  }

  Future<void> getActivity({required int idActivity}) async {
    state = state.copyWith(isLoading: true);
    try {
      final activityResponse =
          await activityRepository.getActivity(idActivity: idActivity);

      state = state.copyWith(
        isLoading: false,
        showActivity: activityResponse.data,
        errorMessageApi: '',
        isErrorInitial: false,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessageApi: e.message,
        isLoading: false,
        isErrorInitial: true,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
        isErrorInitial: true,
      );
    }
  }

  Future<void> deleteActivity({required int idActivity}) async {
    state = state.copyWith(isLoading: true);
    try {
      await activityRepository.deleteActivity(idActivity: idActivity);
      state = state.copyWith(isLoading: false, isDelete: true);
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessageApiDelete: e.message,
        isLoading: false,
        isDelete: false,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessageApiDelete: S.current.Error_inesperado,
        isLoading: false,
        isDelete: false,
      );
    }
  }

  void updateIsDelete() => state = state.copyWith(isDelete: false);

  void updateActivityField({
    required String fieldName,
    required String newValue,
  }) {
    //Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    CreateActivity activity = state.activity!;
    switch (fieldName) {
      case $name:
        if (newValue.isNotEmpty) newValidationErrors.remove($name);
        activity = state.activity!.copyWith(name: newValue);
        break;

      case $description:
        if (newValue.isNotEmpty) newValidationErrors.remove($description);
        activity = state.activity!.copyWith(description: newValue);
        break;

      case $satisfactoryPoints:
        if (newValue.isNotEmpty && newValue != '0') {
          newValidationErrors.remove($satisfactoryPoints);
        }
        activity = state.activity!.copyWith(
            satisfactoryPoints: newValue == '' ? 0 : int.parse(newValue));
        break;

      case $phaseId:
        if (newValue.isNotEmpty && newValue != '0') {
          newValidationErrors.remove($phaseId);
        }
        activity = state.activity!.copyWith(phaseId: int.parse(newValue));
        break;

      case $pictogramSentence:
        List<int> pictograms = [];

        if (newValue.isNotEmpty &&
            newValue.split(',').map(int.parse).toList().length < 31) {
          newValidationErrors.remove($pictogramSentence);
          pictograms = newValue.split(',').map(int.parse).toList();
        }
        activity = state.activity!.copyWith(pictogramSentence: pictograms);
        break;

      default:
        break;
    }

    state = state.copyWith(
      activity: activity,
      validationErrors: newValidationErrors,
    );
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.activity!.name.length <= 2 ||
        state.activity!.name.length >= 100) {
      errors[$name] = S.current.El_nombre_no_puede_ser_menor_a_tres_caracteres;
    }

    if (state.activity!.description.length <= 5 ||
        state.activity!.description.length >= 255) {
      errors[$description] =
          S.current.La_descripcion_no_puede_ser_menor_a_seis_caracteres;
    }

    if (state.activity!.satisfactoryPoints < 1 ||
        state.activity!.satisfactoryPoints > 20) {
      errors[$satisfactoryPoints] = S.current
          .Los_puntos_para_completar_la_actividad_deben_estar_entre_uno_y_veinte;
    }

    if (state.activity!.phaseId <= 0) {
      errors[$phaseId] = S.current.Debe_seleccionar_una_fase_para_la_actividad;
    }

    if (state.activity!.pictogramSentence.isEmpty) {
      errors[$pictogramSentence] =
          S.current.Debe_seleccionar_al_menos_un_pictograma_para_la_solucion;
    } else {
      if (state.activity!.pictogramSentence.length > 31) {
        errors[$pictogramSentence] =
            S.current.El_limite_de_pictogramas_para_la_solucion_es_de_treinta;
      }
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateResponse() {
    state = state.copyWith(
      errorMessageApi: '',
      showtoastAlert: false,
      errorMessageApiDelete: '',
    );
  }

  void updateIsSave({required bool isSave}) {
    state = state.copyWith(isSave: isSave);
  }

  void resetState() {
    state = ActivityState(
      activity: CreateActivity(
        name: '',
        description: '',
        satisfactoryPoints: 0,
        pictogramSentence: [],
        phaseId: 0,
      ),
    );
  }
}

class ActivityState {
  final CreateActivity? activity;
  final Activity? showActivity;
  final bool? showtoastAlert;
  final bool? isLoading;
  final bool? isSave;
  final bool? isDelete;
  final bool? isErrorInitial;
  final String? errorMessageApi;
  final String? errorMessageApiDelete;
  final Map<String, String?> validationErrors;

  ActivityState({
    this.activity,
    this.showActivity,
    this.showtoastAlert = false,
    this.isLoading = false,
    this.isSave = false,
    this.isDelete = false,
    this.isErrorInitial = false,
    this.errorMessageApi,
    this.errorMessageApiDelete,
    this.validationErrors = const {},
  });

  ActivityState copyWith({
    CreateActivity? activity,
    Activity? showActivity,
    bool? showtoastAlert,
    bool? isLoading,
    bool? isSave,
    bool? isDelete,
    bool? isErrorInitial,
    String? errorMessageApi,
    String? errorMessageApiDelete,
    Map<String, String?>? validationErrors,
  }) =>
      ActivityState(
        activity: activity ?? this.activity,
        showActivity: showActivity ?? this.showActivity,
        showtoastAlert: showtoastAlert ?? this.showtoastAlert,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        errorMessageApiDelete: errorMessageApiDelete == ''
            ? null
            : errorMessageApiDelete ?? this.errorMessageApiDelete,
        isLoading: isLoading ?? this.isLoading,
        isSave: isSave ?? this.isSave,
        isDelete: isDelete ?? this.isDelete,
        isErrorInitial: isErrorInitial ?? this.isErrorInitial,
        validationErrors: validationErrors ?? this.validationErrors,
      );
}
