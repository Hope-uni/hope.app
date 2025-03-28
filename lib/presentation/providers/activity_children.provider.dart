import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

final activityChildrenProvider = StateNotifierProvider.autoDispose<
    ActivityChildrenStateNotifier, ActivityChildrenState>((ref) {
  return ActivityChildrenStateNotifier(
      activityRepository: ActivitiesRepositoryImpl());
});

class ActivityChildrenStateNotifier
    extends StateNotifier<ActivityChildrenState> {
  final ActivitiesRepositoryImpl activityRepository;

  ActivityChildrenStateNotifier({required this.activityRepository})
      : super(ActivityChildrenState());

  Future<void> assingActivity({required int idActivity}) async {
    state = state.copyWith(isLoading: true);
    try {
      await activityRepository.assingActivity(
        idActivity: idActivity,
        idsPatients: state.children.map((item) => item.id).toList(),
      );

      state = state.copyWith(isLoading: false, isSave: true, isComplete: true);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
    }
  }

  void addChild(Children child) {
    state = state.copyWith(children: [child, ...state.children]);
  }

  void removeChild(Children child) {
    final List<Children> oldList = state.children;

    oldList.remove(child);

    state = state.copyWith(children: oldList);
  }

  void updateResponse() {
    state = state.copyWith(errorMessageApi: '', isSave: false);
  }
}

class ActivityChildrenState {
  final List<Children> children;
  final bool? isLoading;
  final bool? isSave;
  final bool? isComplete;
  final String? errorMessageApi;

  ActivityChildrenState({
    this.children = const [],
    this.isLoading = false,
    this.isSave = false,
    this.isComplete = false,
    this.errorMessageApi,
  });

  ActivityChildrenState copyWith({
    List<Children>? children,
    bool? isLoading,
    bool? isSave,
    bool? isComplete,
    String? errorMessageApi,
  }) =>
      ActivityChildrenState(
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        children: children ?? this.children,
        isLoading: isLoading ?? this.isLoading,
        isSave: isSave ?? this.isSave,
        isComplete: isComplete ?? this.isComplete,
      );
}
