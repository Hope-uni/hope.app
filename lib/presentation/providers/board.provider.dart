import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';

final boardProvider =
    StateNotifierProvider.autoDispose<BoardNotifier, BoardState>((ref) {
  return BoardNotifier();
});

class BoardNotifier extends StateNotifier<BoardState> {
  BoardNotifier() : super(BoardState());

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
}

class BoardState {
  final List<PictogramAchievements> pictograms;
  final bool? isLoading;
  final String? errorMessageApi;

  BoardState({
    this.isLoading,
    this.errorMessageApi,
    this.pictograms = const [],
  });

  BoardState copyWith({
    List<PictogramAchievements>? pictograms,
    bool? isLoading,
    String? errorMessageApi,
  }) =>
      BoardState(
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
        pictograms: pictograms ?? this.pictograms,
      );
}
