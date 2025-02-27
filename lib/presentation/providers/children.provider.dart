import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final childrenProvider =
    StateNotifierProvider<ChildrenNotifier, ChildrenState>((ref) {
  return ChildrenNotifier(childrenDataSource: ChildrenDataSourceImpl());
});

class ChildrenNotifier extends StateNotifier<ChildrenState> {
  final ChildrenDataSourceImpl childrenDataSource;

  ChildrenNotifier({required this.childrenDataSource}) : super(ChildrenState());

  Future<void> getChildrenTutor() async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginateTutor[$indexPage]!;
    try {
      final children =
          await childrenDataSource.getChildrenTutor(page: indexPage);

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: children.paginate!.pageCount
      };

      state = state.copyWith(
        paginateTutor: paginate,
        childrenTutor: [...state.childrenTutor, ...children.data!],
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

  Future<void> getChildrenTherapist() async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginateTherapist[$indexPage]!;
    try {
      final children =
          await childrenDataSource.getChildrenTherapist(page: indexPage);

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: children.paginate!.pageCount
      };

      state = state.copyWith(
        paginateTherapist: paginate,
        childrenTherapist: [
          ...state.childrenTherapist,
          ...children.data!,
        ],
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
    state = ChildrenState();
  }
}

class ChildrenState {
  final List<Children> childrenTutor;
  final List<Children> childrenTherapist;
  final bool? isLoading;
  final String? errorMessageApi;
  final Map<String, int> paginateTutor;
  final Map<String, int> paginateTherapist;
  final bool? isErrorInitial;

  ChildrenState({
    this.childrenTutor = const [],
    this.childrenTherapist = const [],
    this.paginateTutor = const {$indexPage: 1, $pageCount: 0},
    this.paginateTherapist = const {$indexPage: 1, $pageCount: 0},
    this.isLoading = true,
    this.isErrorInitial = false,
    this.errorMessageApi,
  });

  ChildrenState copyWith({
    List<Children>? childrenTutor,
    List<Children>? childrenTherapist,
    Map<String, int>? paginateTutor,
    Map<String, int>? paginateTherapist,
    bool? isLoading,
    bool? isErrorInitial,
    String? errorMessageApi,
  }) =>
      ChildrenState(
        childrenTutor: childrenTutor ?? this.childrenTutor,
        childrenTherapist: childrenTherapist ?? this.childrenTherapist,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
        isErrorInitial: isErrorInitial ?? this.isErrorInitial,
        paginateTutor: paginateTutor ?? this.paginateTutor,
        paginateTherapist: paginateTherapist ?? this.paginateTherapist,
      );
}
