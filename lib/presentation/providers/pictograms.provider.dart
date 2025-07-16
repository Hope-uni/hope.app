import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final pictogramsProvider =
    StateNotifierProvider.autoDispose<PictogramsNotifier, PictogramsState>(
        (ref) {
  final profileState = ref.read(profileProvider);
  return PictogramsNotifier(
    pictogramsRepository: PictogramsRepositoyImpl(),
    profileState: profileState,
  );
});

class PictogramsNotifier extends StateNotifier<PictogramsState> {
  final PictogramsRepositoyImpl pictogramsRepository;

  List<PictogramAchievements> pictogramsOriginals = [];

  final ProfileState profileState;
  bool isFilter = false;
  int? categoryId;
  String? pictogramName;

  PictogramsNotifier({
    required this.pictogramsRepository,
    required this.profileState,
  }) : super(PictogramsState());

  void _validateFilter({
    int? idCategory,
    String? namePictogram,
  }) {
    if (idCategory != categoryId || namePictogram != pictogramName) {
      state =
          state.copyWith(paginatePictograms: {$indexPage: 1, $pageCount: 0});
      isFilter = true;
    }

    if (idCategory == null && namePictogram == null) {
      if (isFilter == true) {
        state = state.copyWith(
          paginatePictograms: {$indexPage: 1, $pageCount: 0},
        );
      }
      isFilter = false;
    }

    state = state.copyWith(
      isLoading: true,
      isNewFilter: idCategory != categoryId ? true : false,
    );

    categoryId = idCategory;
    pictogramName = namePictogram;
  }

  void _updatePictograms({
    required int indexPage,
    required int pageCount,
    required List<PictogramAchievements>? pictogramData,
    required List<Category>? categoryPictograms,
  }) {
    Map<String, int> paginate = {
      $indexPage: indexPage + 1,
      $pageCount: pageCount
    };

    state = state.copyWith(
      paginatePictograms: paginate,
      pictograms: indexPage == 1
          ? pictogramData ?? []
          : [...state.pictograms, ...pictogramData!],
      categoryPictograms:
          indexPage == 1 ? categoryPictograms ?? [] : state.categoryPictograms,
      isLoading: false,
      isErrorInitial: false,
      isNewFilter: false,
    );
  }

  Future<void> getPictograms({
    int? idCategory,
    String? namePictogram,
  }) async {
    _validateFilter(idCategory: idCategory, namePictogram: namePictogram);

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

      _updatePictograms(
        indexPage: indexPage,
        pageCount: pictograms.paginate!.pageCount,
        categoryPictograms: categoryPictograms,
        pictogramData: pictograms.data,
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
    _validateFilter(idCategory: idCategory, namePictogram: namePictogram);
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

      _updatePictograms(
        indexPage: indexPage,
        pageCount: customPictograms.paginate!.pageCount,
        categoryPictograms: categoryPictograms,
        pictogramData: customPictograms.data,
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

  Future<void> getPictogramsPatient({
    int? idCategory,
    List<PictogramAchievements>? pictogramsSolution,
  }) async {
    if (!profileState.permmisions!.contains($listCustomPictogram)) {
      _onlyGetCateories();
      state = state.copyWith(isLoading: false);
      return;
    }
    _validateFilter(idCategory: idCategory, namePictogram: null);
    final indexPage = state.paginatePictograms[$indexPage]!;
    try {
      final pictogramsPatient = await pictogramsRepository.getPictogramsPatient(
        indexPage: indexPage,
        idCategory: idCategory,
      );

      List<Category>? categoryPictograms = state.categoryPictograms;

      if (indexPage == 1 && idCategory == null) {
        categoryPictograms = await getCategoryPictograms();
      }

      // Lista original desde el backend
      List<PictogramAchievements> pictogramList = pictogramsPatient.data ?? [];

      pictogramsOriginals = indexPage == 1
          ? pictogramsPatient.data ?? []
          : [...pictogramsOriginals, ...pictogramsPatient.data!];

      if (pictogramsSolution != null && pictogramsSolution.isNotEmpty) {
        final idsToExclude = pictogramsSolution.map((e) => e.id).toSet();

        pictogramList = pictogramList
            .where((picto) => !idsToExclude.contains(picto.id))
            .toList();
      }

      _updatePictograms(
        indexPage: indexPage,
        pageCount: pictogramsPatient.paginate!.pageCount,
        categoryPictograms: categoryPictograms,
        pictogramData: pictogramList,
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
    if (!profileState.permmisions!.contains($listCategory)) {
      return null;
    }
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

  Future<void> _onlyGetCateories() async {
    final categoryPictograms = await getCategoryPictograms();
    state = state.copyWith(categoryPictograms: categoryPictograms);
  }

  void updateResponse() => state = state.copyWith(errorMessageApi: '');

  void deletePictogram({required int idPictogram}) {
    List<PictogramAchievements> listPictogram = List.from(state.pictograms);
    listPictogram.removeWhere((item) => item.id == idPictogram);

    state = state.copyWith(pictograms: listPictogram);
  }

  void addPictogram({required PictogramAchievements pictogram}) {
    List<PictogramAchievements> listPictogram = List.from(state.pictograms);
    listPictogram.add(pictogram);
    listPictogram
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    state = state.copyWith(pictograms: listPictogram);
  }

  void updateCustomPictogram({required PictogramAchievements pictogram}) {
    List<PictogramAchievements> listPictogram = state.pictograms;
    final index = listPictogram.indexWhere((item) => item.id == pictogram.id);
    listPictogram[index] = pictogram;
    state = state.copyWith(pictograms: listPictogram);
  }

  void setPictogramsPatients() {
    state = state.copyWith(pictograms: pictogramsOriginals);
  }
}

class PictogramsState {
  final List<PictogramAchievements> pictograms;
  final List<Category> categoryPictograms;
  final bool? isNewFilter;
  final bool? isLoading;
  final String? errorMessageApi;
  final bool? isErrorInitial;
  final Map<String, int> paginatePictograms;

  PictogramsState({
    this.pictograms = const [],
    this.categoryPictograms = const [],
    this.paginatePictograms = const {$indexPage: 1, $pageCount: 0},
    this.isLoading = false,
    this.isNewFilter,
    this.isErrorInitial = false,
    this.errorMessageApi,
  });

  PictogramsState copyWith({
    List<PictogramAchievements>? pictograms,
    List<Category>? categoryPictograms,
    Map<String, int>? paginatePictograms,
    bool? isLoading,
    bool? isNewFilter,
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
        isNewFilter: isNewFilter ?? this.isNewFilter,
        paginatePictograms: paginatePictograms ?? this.paginatePictograms,
      );
}
