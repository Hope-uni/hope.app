import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

final childProvider = StateNotifierProvider<ChildNotifier, ChildState>((ref) {
  return ChildNotifier(childrenDataSource: ChildrenDataSourceImpl());
});

class ChildNotifier extends StateNotifier<ChildState> {
  final ChildrenDataSourceImpl childrenDataSource;

  ChildNotifier({required this.childrenDataSource}) : super(ChildState());

  Future<void> getChild({required int idChild}) async {
    state = state.copyWith(isLoading: true);
    try {
      final child = await childrenDataSource.getChild(idChild: idChild);
      state = state.copyWith(child: child.data, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
    }
  }

  void updateBirthday(DateTime newDate) {
    if (state.child == null) return; // Evita errores si profile es null
    state.child!.birthday = "${newDate.year}-${newDate.month}-${newDate.day}";
    state = state;
  }
}

class ChildState {
  final Child? child;
  final bool isLoading;
  final bool? isError;
  final String? errorMessageApi;

  ChildState({
    this.child,
    this.isLoading = true,
    this.isError,
    this.errorMessageApi,
  });

  ChildState copyWith({
    Child? child,
    bool? isLoading,
    bool? isError,
    String? errorMessageApi,
  }) =>
      ChildState(
        child: child ?? this.child,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
      );
}
