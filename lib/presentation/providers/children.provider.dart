import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final searchPatients = StateProvider<String>((ref) => '');

final childrenProvider =
    StateNotifierProvider.autoDispose<ChildrenNotifier, ChildrenState>((ref) {
  return ChildrenNotifier(childrenDataSource: ChildrenDataSourceImpl());
});

class ChildrenNotifier extends StateNotifier<ChildrenState> {
  final ChildrenDataSourceImpl childrenDataSource;

  ChildrenNotifier({required this.childrenDataSource}) : super(ChildrenState());

  Future<void> getChildrenTutor() async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginateChildren[$indexPage]!;
    try {
      final children =
          await childrenDataSource.getChildrenTutor(page: indexPage);

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: children.paginate!.pageCount
      };

      state = state.copyWith(
        paginateChildren: paginate,
        children: [...state.children, ...children.data!],
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

  Future<void> getChildrenTherapist({int? idActivity}) async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginateChildren[$indexPage]!;
    try {
      final children = await childrenDataSource.getChildrenTherapist(
        page: indexPage,
        activityId: idActivity,
      );

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: children.paginate!.pageCount
      };

      state = state.copyWith(
        paginateChildren: paginate,
        children: [
          ...state.children,
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

  Future<void> getChildrenforActivity({required int idActivity}) async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginateChildren[$indexPage]!;
    try {
      final children = await childrenDataSource.getChildrenforActivity(
        page: indexPage,
        idActivity: idActivity,
      );

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: children.paginate!.pageCount
      };

      state = state.copyWith(
        paginateChildren: paginate,
        children: [...state.children, ...children.data!],
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

  void updateResponse() {
    state = state.copyWith(errorMessageApi: '', isErrorInitial: false);
  }

  void removeChildTherapist(Children child) {
    final List<Children> oldList = state.children;

    oldList.remove(child);

    state = state.copyWith(children: oldList);
  }

  void resetState() => state = ChildrenState();
}

class ChildrenState {
  final List<Children> children;
  final bool? isLoading;
  final String? errorMessageApi;
  final Map<String, int> paginateChildren;
  final bool? isErrorInitial;

  ChildrenState({
    this.children = const [],
    this.paginateChildren = const {$indexPage: 1, $pageCount: 0},
    this.isLoading = true,
    this.isErrorInitial = false,
    this.errorMessageApi,
  });

  ChildrenState copyWith({
    List<Children>? children,
    Map<String, int>? paginateChildren,
    bool? isLoading,
    bool? isErrorInitial,
    String? errorMessageApi,
  }) =>
      ChildrenState(
        children: children ?? this.children,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
        isErrorInitial: isErrorInitial ?? this.isErrorInitial,
        paginateChildren: paginateChildren ?? this.paginateChildren,
      );
}
