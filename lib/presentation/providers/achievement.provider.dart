import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final achievementProvider =
    StateNotifierProvider.autoDispose<AchievementNotifier, AchievementState>(
        (ref) {
  return AchievementNotifier(
    achievementRepository: AchievementRespositoryImpl(),
  );
});

class AchievementNotifier extends StateNotifier<AchievementState> {
  final AchievementRespositoryImpl achievementRepository;

  AchievementNotifier({required this.achievementRepository})
      : super(AchievementState());

  Future<void> getAchievements({required int idPatient}) async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginateAchievement[$indexPage]!;
    try {
      final achievement = await achievementRepository.getAchievementByPatient(
        indexPage: indexPage,
        idPatient: idPatient,
      );

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: achievement.paginate!.pageCount
      };

      state = state.copyWith(
        paginateAchievement: paginate,
        achievement: [...state.achievement, ...achievement.data!],
        isLoading: false,
        isErrorInitial: false,
      );
    } on CustomError catch (e) {
      if (indexPage == 1) state = state.copyWith(isErrorInitial: true);
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
    } catch (e) {
      if (indexPage == 1) state = state.copyWith(isErrorInitial: true);
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
    }
  }

  Future<void> assignAchievement({
    required int idPatient,
    required int achievementId,
  }) async {
    state = state.copyWith(isAssign: true);
    try {
      final achievement = await achievementRepository.assignAchievement(
        achievementId: achievementId,
        patientId: idPatient,
      );

      List<PictogramAchievements> listPictogram = List.from(state.achievement);
      listPictogram.removeWhere((item) => item.id == achievement.data!.id);

      state = state.copyWith(
        isAssign: false,
        achievement: listPictogram,
        isComplete: true,
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isAssign: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isAssign: false,
      );
    }
  }

  void updateResponse() =>
      state = state.copyWith(errorMessageApi: '', isComplete: false);
}

class AchievementState {
  final bool? isLoading;
  final bool? isAssign;
  final bool? isComplete;
  final String? errorMessageApi;
  final bool? isErrorInitial;
  final Map<String, int> paginateAchievement;
  final List<PictogramAchievements> achievement;

  AchievementState({
    this.paginateAchievement = const {$indexPage: 1, $pageCount: 0},
    this.achievement = const [],
    this.isLoading,
    this.isAssign,
    this.isComplete,
    this.errorMessageApi,
    this.isErrorInitial,
  });

  AchievementState copyWith({
    List<PictogramAchievements>? achievement,
    Map<String, int>? paginateAchievement,
    bool? isLoading,
    bool? isAssign,
    bool? isComplete,
    bool? isErrorInitial,
    String? errorMessageApi,
  }) =>
      AchievementState(
        achievement: achievement ?? this.achievement,
        paginateAchievement: paginateAchievement ?? this.paginateAchievement,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
        isAssign: isAssign ?? this.isAssign,
        isComplete: isComplete ?? this.isComplete,
        isErrorInitial: isErrorInitial ?? this.isErrorInitial,
      );
}
