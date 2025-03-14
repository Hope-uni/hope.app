import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final isCreateActivity = StateProvider<bool>((ref) => false);

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
            newActivity: CreateActivity(
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
          await activityDataSource.createActivity(activity: state.newActivity!);

      final newActivity = addActivity(activity: activityResponse.data!);

      state = state.copyWith(
        isLoading: false,
        newActivity: newActivity,
        showtoastAlert: true,
        errorMessageApiCreate: '',
      );
    } on CustomError catch (e) {
      state =
          state.copyWith(errorMessageApiCreate: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApiCreate: S.current.Error_inesperado,
        isLoading: false,
      );
    }
  }

  CreateActivity addActivity({required Activity activity}) {
    final CreateActivity newActivity = CreateActivity(
      name: activity.name,
      description: activity.description,
      satisfactoryPoints: activity.satisfactoryPoints,
      pictogramSentence:
          activity.activitySolution.map((item) => item.id).toList(),
      phaseId: activity.phase.id,
    );
    return newActivity;
  }

  void updateActivityField(String fieldName, String newValue) {
    //Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    CreateActivity activity = state.newActivity!;
    switch (fieldName) {
      case $name:
        if (newValue.isNotEmpty) newValidationErrors.remove($name);
        activity = state.newActivity!.copyWith(name: newValue);
        break;

      case $description:
        if (newValue.isNotEmpty) newValidationErrors.remove($description);
        activity = state.newActivity!.copyWith(description: newValue);
        break;

      case $satisfactoryPoints:
        if (newValue.isNotEmpty && newValue != '0') {
          newValidationErrors.remove($satisfactoryPoints);
        }
        activity = state.newActivity!.copyWith(
            satisfactoryPoints: newValue == '' ? 0 : int.parse(newValue));
        break;

      case $phaseId:
        if (newValue.isNotEmpty && newValue != '0') {
          newValidationErrors.remove($phaseId);
        }
        activity = state.newActivity!.copyWith(phaseId: int.parse(newValue));
        break;

      case $pictogramSentence:
        List<int> pictograms = [];
        if (newValue.isNotEmpty) {
          newValidationErrors.remove($pictogramSentence);
          pictograms = newValue.split(',').map(int.parse).toList();
        }

        activity = state.newActivity!.copyWith(pictogramSentence: pictograms);
        break;

      default:
        break;
    }

    state = state.copyWith(
      newActivity: activity,
      validationErrors: newValidationErrors,
    );
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.newActivity!.name.isEmpty) {
      errors[$name] = S.current.El_nombre_de_la_actividad_no_puede_estar_vacio;
    }

    if (state.newActivity!.description.isEmpty) {
      errors[$description] =
          S.current.La_descripcion_de_la_actividad_no_puede_estar_vacia;
    }

    if (state.newActivity!.satisfactoryPoints <= 0) {
      errors[$satisfactoryPoints] = S.current
          .Los_puntos_para_completar_la_actividad_no_puede_ser_cero_o_estar_vacio;
    }

    if (state.newActivity!.phaseId <= 0) {
      errors[$phaseId] = S.current.Debe_seleccionar_una_fase_para_la_actividad;
    }

    if (state.newActivity!.pictogramSentence.isEmpty) {
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
    state = state.copyWith(errorMessageApiCreate: '', showtoastAlert: false);
  }

  void updateIsSave(bool isSave) {
    state = state.copyWith(isSave: isSave);
  }

  void resetState() {
    state = ActivityState();
  }
}

class ActivityState {
  final CreateActivity? newActivity;
  final bool? showtoastAlert;
  final bool? isLoading;
  final bool? isSave;
  final String? errorMessageApiCreate;
  final Map<String, String?> validationErrors;

  ActivityState({
    this.newActivity,
    this.showtoastAlert = false,
    this.isLoading = false,
    this.isSave = false,
    this.errorMessageApiCreate,
    this.validationErrors = const {},
  });

  ActivityState copyWith({
    CreateActivity? newActivity,
    bool? showtoastAlert,
    bool? isLoading,
    bool? isSave,
    String? errorMessageApiCreate,
    Map<String, String?>? validationErrors,
  }) =>
      ActivityState(
        newActivity: newActivity ?? this.newActivity,
        showtoastAlert: showtoastAlert ?? this.showtoastAlert,
        errorMessageApiCreate: errorMessageApiCreate == ''
            ? null
            : errorMessageApiCreate ?? this.errorMessageApiCreate,
        isLoading: isLoading ?? this.isLoading,
        isSave: isSave ?? this.isSave,
        validationErrors: validationErrors ?? this.validationErrors,
      );
}
