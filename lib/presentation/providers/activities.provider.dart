import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final searchNameActivity = StateProvider<String>((ref) => '');

final activitiesProvider =
    StateNotifierProvider.autoDispose<ActivitiesNotifier, ActivitiesState>(
        (ref) {
  final activityRepository = ActivitiesRepositoryImpl();
  return ActivitiesNotifier(activityRepository: activityRepository);
});

class ActivitiesNotifier extends StateNotifier<ActivitiesState> {
  final ActivitiesRepositoryImpl activityRepository;

  ActivitiesNotifier({required this.activityRepository})
      : super(
          ActivitiesState(),
        );

  // Método para cargar más actividades
  Future<void> getActivities() async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginateActivities[$indexPage]!;
    try {
      final children =
          await activityRepository.getAllActivities(indexPage: indexPage);

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: children.paginate!.pageCount
      };

      state = state.copyWith(
        paginateActivities: paginate,
        activities: [...state.activities, ...children.data!],
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

  void updateErrorMessage() {
    state = state.copyWith(errorMessageApi: '');
  }

  void resetIsErrorInitial() {
    state = state.copyWith(isErrorInitial: false);
  }

  void resetState() {
    state = ActivitiesState();
  }
}

class ActivitiesState {
  final List<Activities> activities;
  final Map<String, int> paginateActivities;
  final bool? isLoading;
  final String? errorMessageApi;
  final bool? isErrorInitial;

  ActivitiesState({
    this.activities = const [],
    this.paginateActivities = const {$indexPage: 1, $pageCount: 0},
    this.isLoading = true,
    this.isErrorInitial = false,
    this.errorMessageApi,
  });

  ActivitiesState copyWith({
    List<Activities>? activities,
    Map<String, int>? paginateActivities,
    bool? isLoading,
    bool? isErrorInitial,
    String? errorMessageApi,
  }) =>
      ActivitiesState(
        activities: activities ?? this.activities,
        paginateActivities: paginateActivities ?? this.paginateActivities,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
        isErrorInitial: isErrorInitial ?? this.isErrorInitial,
      );
}
