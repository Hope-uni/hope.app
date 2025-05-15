import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart'
    show ActivitiesRepositoryImpl, CustomError;

final boardProvider =
    StateNotifierProvider.autoDispose<BoardNotifier, BoardState>((ref) {
  return BoardNotifier(activityRepository: ActivitiesRepositoryImpl());
});

class BoardNotifier extends StateNotifier<BoardState> {
  final ActivitiesRepositoryImpl activityRepository;
  BoardNotifier({required this.activityRepository})
      : super(
          BoardState(
            patientActivity: PatientActivity(
                latestCompletedActivity: null, currentActivity: null),
          ),
        );

  Future<void> getPatientActivity() async {
    state = state.copyWith(isLoading: true);
    try {
      final patientActivity = await activityRepository.currentActivity();
      state = state.copyWith(
        patientActivity: patientActivity.data,
        isLoading: false,
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

  Future<bool> checkAnswer() async {
    state = state.copyWith(isCheking: true);
    try {
      final idActivity = state.patientActivity!.currentActivity == null
          ? state.patientActivity!.latestCompletedActivity!.id
          : state.patientActivity!.currentActivity!.id;

      final checkActivity = await activityRepository.checkAnswer(
        idActivity: idActivity,
        idSolutions: state.pictograms.map((item) => item.id).toList(),
      );

      if (checkActivity.data!.satisfactoryAttempts ==
          checkActivity.data!.satisfactoryPoints) {
        if (state.patientActivity!.latestCompletedActivity == null) {
          state = state.copyWith(
            isCheking: false,
            patientActivity: PatientActivity(
              latestCompletedActivity: checkActivity.data,
              currentActivity: null,
            ),
            checkSuccess:
                '${S.current.La_actividad_asignada_se_completo_con_exito}, ${checkActivity.message}',
            isCompleteActivity: true,
          );
        } else {
          state = state.copyWith(
            isCheking: false,
            checkSuccess:
                '${S.current.La_actividad_asignada_se_completo_con_exito}, ${checkActivity.message}',
          );
        }
      } else {
        state = state.copyWith(
          isCheking: false,
          checkSuccess: checkActivity.message,
        );
      }

      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isCheking: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isCheking: false,
      );
      return false;
    }
  }

  void addPictogramSolution({required PictogramAchievements newPictogram}) {
    state = state.copyWith(pictograms: [...state.pictograms, newPictogram]);
  }

  void onChangeOrderSolution(int indexOld, int indexNew) {
    final pictogram = state.pictograms[indexOld];
    if (indexOld < indexNew) {
      indexNew -= 1;
    }

    state.pictograms.removeAt(indexOld);
    state.pictograms.insert(indexNew, pictogram);
    state = state.copyWith(pictograms: state.pictograms);
  }

  void clearPictogramSolution() {
    state = state.copyWith(pictograms: []);
  }

  void updateResponse() {
    state = state.copyWith(
      errorMessageApi: '',
      checkSuccess: '',
      isCompleteActivity: false,
    );
  }
}

class BoardState {
  final List<PictogramAchievements> pictograms;
  final PatientActivity? patientActivity;
  final bool? isLoading;
  final bool? isCheking;
  final String? checkSuccess;
  final String? errorMessageApi;
  final bool? isCompleteActivity;

  BoardState({
    this.patientActivity,
    this.isLoading,
    this.isCheking,
    this.isCompleteActivity = false,
    this.errorMessageApi,
    this.checkSuccess,
    this.pictograms = const [],
  });

  BoardState copyWith({
    List<PictogramAchievements>? pictograms,
    PatientActivity? patientActivity,
    bool? isLoading,
    bool? isCheking,
    String? checkSuccess,
    String? errorMessageApi,
    bool? isCompleteActivity,
  }) =>
      BoardState(
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        checkSuccess:
            checkSuccess == '' ? null : checkSuccess ?? this.checkSuccess,
        isLoading: isLoading ?? this.isLoading,
        isCheking: isCheking ?? this.isCheking,
        isCompleteActivity: isCompleteActivity ?? this.isCompleteActivity,
        patientActivity: patientActivity ?? this.patientActivity,
        pictograms: pictograms ?? this.pictograms,
      );
}
