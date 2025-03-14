import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final activityProvider =
    StateNotifierProvider.autoDispose<ActivityNotifier, ActivityState>((ref) {
  final activityDataSource = ActivitiesDataSourceImpl();
  return ActivityNotifier(activityDataSource: activityDataSource);
});

class ActivityNotifier extends StateNotifier<ActivityState> {
  final ActivitiesDataSourceImpl activityDataSource;

  ActivityNotifier({required this.activityDataSource})
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
          await activityDataSource.createActivity(activity: state.activity!);

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
          await activityDataSource.getActivity(idActivity: idActivity);

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

  void updateActivityField(String fieldName, String newValue) {
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
        if (newValue.isNotEmpty) {
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

    if (state.activity!.name.isEmpty) {
      errors[$name] = S.current.El_nombre_de_la_actividad_no_puede_estar_vacio;
    }

    if (state.activity!.description.isEmpty) {
      errors[$description] =
          S.current.La_descripcion_de_la_actividad_no_puede_estar_vacia;
    }

    if (state.activity!.satisfactoryPoints <= 0) {
      errors[$satisfactoryPoints] = S.current
          .Los_puntos_para_completar_la_actividad_no_puede_ser_cero_o_estar_vacio;
    }

    if (state.activity!.phaseId <= 0) {
      errors[$phaseId] = S.current.Debe_seleccionar_una_fase_para_la_actividad;
    }

    if (state.activity!.pictogramSentence.isEmpty) {
      errors[$pictogramSentence] =
          S.current.Debe_seleccionar_al_menos_un_pictograma_para_la_solucion;
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateErrorMessage() {
    state = state.copyWith(errorMessageApi: '', showtoastAlert: false);
  }

  void updateIsSave(bool isSave) {
    state = state.copyWith(isSave: isSave);
  }

  void resetState() {
    state = ActivityState();
  }
}

class ActivityState {
  final CreateActivity? activity;
  final Activity? showActivity;
  final bool? showtoastAlert;
  final bool? isLoading;
  final bool? isSave;
  final bool? isErrorInitial;
  final String? errorMessageApi;
  final Map<String, String?> validationErrors;

  ActivityState({
    this.activity,
    this.showActivity,
    this.showtoastAlert = false,
    this.isLoading = false,
    this.isSave = false,
    this.isErrorInitial = false,
    this.errorMessageApi,
    this.validationErrors = const {},
  });

  ActivityState copyWith({
    CreateActivity? activity,
    Activity? showActivity,
    bool? showtoastAlert,
    bool? isLoading,
    bool? isSave,
    bool? isErrorInitial,
    String? errorMessageApi,
    Map<String, String?>? validationErrors,
  }) =>
      ActivityState(
        activity: activity ?? this.activity,
        showActivity: showActivity ?? this.showActivity,
        showtoastAlert: showtoastAlert ?? this.showtoastAlert,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
        isSave: isSave ?? this.isSave,
        isErrorInitial: isErrorInitial ?? this.isErrorInitial,
        validationErrors: validationErrors ?? this.validationErrors,
      );
}
