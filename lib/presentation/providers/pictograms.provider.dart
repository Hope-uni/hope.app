import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final pictogramsProvider =
    StateNotifierProvider.autoDispose<PictogramsNotifier, PictogramsState>(
        (ref) {
  return PictogramsNotifier(pictogramsRepository: PictogramsRepositoyImpl());
});

class PictogramsNotifier extends StateNotifier<PictogramsState> {
  final PictogramsRepositoyImpl pictogramsRepository;

  bool isFilter = false;

  PictogramsNotifier({required this.pictogramsRepository})
      : super(PictogramsState());

  Future<void> getPictograms({
    int? idCategory,
    String? namePictogram,
  }) async {
    if (idCategory != null || namePictogram != null) {
      state = state.copyWith(
        isLoading: true,
        paginatePictograms: {$indexPage: 1, $pageCount: 0},
      );
      isFilter = true;
    } else {
      if (isFilter == true) {
        state = state.copyWith(
          paginatePictograms: {$indexPage: 1, $pageCount: 0},
        );
      }
      state = state.copyWith(isLoading: true);
      isFilter = false;
    }

    final indexPage = state.paginatePictograms[$indexPage]!;
    try {
      final pictograms = await pictogramsRepository.getPictograms(
        indexPage: indexPage,
        idCategory: idCategory,
        namePictogram: namePictogram,
      );

      List<Category>? categoryPictograms = state.categoryPictograms;

      if (indexPage == 1 && idCategory == null && namePictogram == null) {
        categoryPictograms = await getCategoryPictograms();
      }

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: pictograms.paginate!.pageCount
      };

      state = state.copyWith(
        paginatePictograms: paginate,
        pictograms: indexPage == 1
            ? pictograms.data ?? []
            : [...state.pictograms, ...pictograms.data!],
        categoryPictograms: indexPage == 1
            ? categoryPictograms ?? []
            : state.categoryPictograms,
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

  Future<void> getCustomPictograms({
    required int idChild,
    int? idCategory,
    String? namePictogram,
  }) async {
    if (idCategory != null || namePictogram != null) {
      state = state.copyWith(
        isLoading: true,
        paginatePictograms: {$indexPage: 1, $pageCount: 0},
      );
      isFilter = true;
    } else {
      if (isFilter == true) {
        state = state.copyWith(
          paginatePictograms: {$indexPage: 1, $pageCount: 0},
        );
      }
      state = state.copyWith(isLoading: true);
      isFilter = false;
    }
    final indexPage = state.paginatePictograms[$indexPage]!;
    try {
      final customPictograms = await pictogramsRepository.getCustomPictograms(
        indexPage: indexPage,
        idChild: idChild,
        idCategory: idCategory,
        namePictogram: namePictogram,
      );

      List<Category>? categoryPictograms = state.categoryPictograms;

      if (indexPage == 1 && idCategory == null && namePictogram == null) {
        categoryPictograms = await getCategoryPictograms();
      }

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: customPictograms.paginate!.pageCount
      };

      state = state.copyWith(
        paginatePictograms: paginate,
        pictograms: indexPage == 1
            ? customPictograms.data ?? []
            : [...state.pictograms, ...customPictograms.data!],
        categoryPictograms: indexPage == 1
            ? categoryPictograms ?? []
            : state.categoryPictograms,
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

  Future<List<Category>?> getCategoryPictograms() async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginatePictograms[$indexPage]!;
    try {
      final categoryPictograms =
          await pictogramsRepository.getCategoryPictograms();

      return categoryPictograms.data;
    } on CustomError catch (e) {
      if (indexPage == 1) state = state.copyWith(isErrorInitial: true);
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
      return null;
    } catch (e) {
      if (indexPage == 1) state = state.copyWith(isErrorInitial: true);
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
      return null;
    }
  }

  void resetFilters({
    required String? namePictogram,
    required bool isCustom,
    required int idChild,
  }) {
    state = state.copyWith(paginatePictograms: {$indexPage: 1, $pageCount: 0});
    if (isCustom) {
      getCustomPictograms(idChild: idChild, namePictogram: namePictogram);
    } else {
      getPictograms(namePictogram: namePictogram);
    }
  }

  void updateResponse() {
    state = state.copyWith(errorMessageApi: '', isErrorInitial: false);
  }

  void deleteCustomPictogram({required int idPictogram}) {
    List<PictogramAchievements> listPictogram = state.pictograms;
    listPictogram.removeWhere((item) => item.id == idPictogram);

    state = state.copyWith(pictograms: listPictogram);
  }

  void updateCustomPictogram({required PictogramAchievements pictogram}) {
    List<PictogramAchievements> listPictogram = state.pictograms;
    final index = listPictogram.indexWhere((item) => item.id == pictogram.id);
    listPictogram[index] = pictogram;
    state = state.copyWith(pictograms: listPictogram);
  }
}

class PictogramsState {
  final List<PictogramAchievements> pictograms;
  final List<Category> categoryPictograms;
  final bool? isLoading;
  final String? errorMessageApi;
  final bool? isErrorInitial;
  final Map<String, int> paginatePictograms;

  PictogramsState({
    this.pictograms = const [],
    this.categoryPictograms = const [],
    this.paginatePictograms = const {$indexPage: 1, $pageCount: 0},
    this.isLoading = true,
    this.isErrorInitial = false,
    this.errorMessageApi,
  });

  PictogramsState copyWith({
    List<PictogramAchievements>? pictograms,
    List<Category>? categoryPictograms,
    Map<String, int>? paginatePictograms,
    bool? isLoading,
    bool? isErrorInitial,
    String? errorMessageApi,
  }) =>
      PictogramsState(
        pictograms: pictograms ?? this.pictograms,
        categoryPictograms: categoryPictograms ?? this.categoryPictograms,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
        isErrorInitial: isErrorInitial ?? this.isErrorInitial,
        paginatePictograms: paginatePictograms ?? this.paginatePictograms,
      );
}
