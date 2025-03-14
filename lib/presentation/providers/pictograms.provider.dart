import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final pictogramsProvider =
    StateNotifierProvider<PictogramsNotifier, PictogramsState>((ref) {
  return PictogramsNotifier(pictogramsDataSource: PictogramsDataSourceImpl());
});

class PictogramsNotifier extends StateNotifier<PictogramsState> {
  final PictogramsDataSourceImpl pictogramsDataSource;

  PictogramsNotifier({required this.pictogramsDataSource})
      : super(PictogramsState());

  Future<void> getPictograms() async {
    state = state.copyWith(isLoading: true);
    final indexPage = state.paginatePictograms[$indexPage]!;
    try {
      final pictograms =
          await pictogramsDataSource.getPictograms(indexPage: indexPage);

      List<Category>? categoryPictograms = [];

      if (indexPage == 1) {
        categoryPictograms = await getCategoryPictograms();
      }

      Map<String, int> paginate = {
        $indexPage: indexPage + 1,
        $pageCount: pictograms.paginate!.pageCount
      };

      state = state.copyWith(
        paginatePictograms: paginate,
        pictograms: [
          ...state.pictograms,
          ...pictograms.data!,
        ],
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
          await pictogramsDataSource.getCategoryPictograms();

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

  void updateErrorMessage() {
    state = state.copyWith(errorMessageApi: '');
  }

  void resetIsErrorInitial() {
    state = state.copyWith(isErrorInitial: false);
  }

  void resetState() {
    state = PictogramsState();
  }

  void resetFilter() {
    state = state.copyWith(namePicto: '', typePicto: '');
  }

  void onNamePictoChange(String value) {
    final newNamePicto = value;
    state = state.copyWith(namePicto: newNamePicto);
  }

  void onTypePictoChange(String value) {
    final newTypePicto = value;
    state = state.copyWith(typePicto: newTypePicto);
  }
}

class PictogramsState {
  final List<PictogramAchievements> pictograms;
  final List<Category> categoryPictograms;
  final bool? isLoading;
  final String? errorMessageApi;
  final bool? isErrorInitial;
  final Map<String, int> paginatePictograms;
  final String? typePicto;
  final String namePicto;

  PictogramsState({
    this.pictograms = const [],
    this.categoryPictograms = const [],
    this.paginatePictograms = const {$indexPage: 1, $pageCount: 0},
    this.isLoading = true,
    this.isErrorInitial = false,
    this.errorMessageApi,
    this.typePicto,
    this.namePicto = '',
  });

  PictogramsState copyWith({
    List<PictogramAchievements>? pictograms,
    List<Category>? categoryPictograms,
    Map<String, int>? paginatePictograms,
    bool? isLoading,
    bool? isErrorInitial,
    String? errorMessageApi,
    String? typePicto,
    String? namePicto,
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
        namePicto: namePicto ?? this.namePicto,
        typePicto: typePicto == '' ? null : typePicto ?? this.typePicto,
      );
}
