import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/providers/providers.dart';
import 'package:hope_app/presentation/utils/utils.dart';

final selectDelete = StateProvider<bool>((ref) => false);

final customPictogramProvider = StateNotifierProvider.autoDispose<
    CustomPictogramNotifier, CustomPictogramState>((ref) {
  final notifierPictograms = ref.read(pictogramsProvider.notifier);

  return CustomPictogramNotifier(
    notifierPictograms: notifierPictograms,
    pictogramsRepository: PictogramsRepositoyImpl(),
  );
});

class CustomPictogramNotifier extends StateNotifier<CustomPictogramState> {
  final PictogramsRepositoyImpl pictogramsRepository;
  final PictogramsNotifier notifierPictograms;

  CustomPictogramNotifier({
    required this.pictogramsRepository,
    required this.notifierPictograms,
  }) : super(CustomPictogramState());

  Future<bool> createCustomPictogram() async {
    state = state.copyWith(isLoading: true);
    try {
      final customPicto = _setCustomPictogram();
      final response = await pictogramsRepository.createCustomPictogram(
        customPictogram: customPicto,
      );

      state = state.copyWith(
        isLoading: false,
        isCreate: true,
        pictogram: response.data,
      );
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
      return false;
    } catch (e) {
      state = state.copyWith(
          errorMessageApi: S.current.Error_inesperado, isLoading: false);
      return false;
    }
  }

  Future<void> deleteCustomPictogram() async {
    state = state.copyWith(isLoading: true);
    try {
      await pictogramsRepository.deleteCustomPictograms(
        idChild: state.idChild,
        idPictogram: state.pictogram!.id,
      );

      notifierPictograms.deleteCustomPictogram(
        idPictogram: state.pictogram!.id,
      );

      state = state.copyWith(
        isLoading: false,
        isDelete: true,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessageApi: e.message,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
    }
  }

  Future<void> updateCustomPictogram() async {
    state = state.copyWith(isLoading: true);
    try {
      final pictogram = await pictogramsRepository.updateCustomPictograms(
        pictogram: CustomPictogram(
          name: state.pictogram!.name,
          imageUrl: state.pictogram!.imageUrl,
          patientId: state.idChild,
        ),
        idPictogram: state.pictogram!.id,
      );

      notifierPictograms.updateCustomPictogram(pictogram: pictogram.data!);

      state = state.copyWith(
        isLoading: false,
        isUpdate: true,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessageApi: e.message,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
    }
  }

  CustomPictogram _setCustomPictogram() {
    final customPictogram = CustomPictogram(
      imageUrl: state.pictogram!.imageUrl,
      name: state.pictogram!.name,
      patientId: state.idChild,
      pictogramId: state.pictogram!.id,
    );

    return customPictogram;
  }

  void loadCustomPictogram({required PictogramAchievements pictogram}) {
    state = state.copyWith(pictogram: pictogram);
  }

  void updateRequest() {
    state = state.copyWith(
      errorMessageApi: '',
      isCreate: false,
      isDelete: false,
      isUpdate: false,
      pictogram: null,
    );
  }

  bool checkFields() {
    Map<String, String?> errors = {};

    if (state.pictogram!.name.isEmpty) {
      errors[$name] = S.current.El_nombre_del_pictograma_no_puede_estar_vacio;
    } else {
      if (state.pictogram!.name.length <= 2 ||
          state.pictogram!.name.length >= 61) {
        errors[$name] = S.current
            .El_nombre_no_puede_ser_menor_a_tres_o_mayor_a_sesenta_caracteres;
      }
    }

    state = state.copyWith(validationErrors: errors);

    if (errors.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateName(String newValue) {
    //Borra el error si el usuario ingresa texto
    final Map<String, String?> newValidationErrors =
        Map.from(state.validationErrors);

    PictogramAchievements customPictogram = state.pictogram!;

    if (newValue.isNotEmpty) newValidationErrors.remove($name);
    customPictogram = state.pictogram!.copyWith(name: newValue);

    state = state.copyWith(
      pictogram: customPictogram,
      validationErrors: newValidationErrors,
    );
  }

  void setIdChild({required int idChild}) {
    state = state.copyWith(idChild: idChild);
  }
}

class CustomPictogramState {
  final int idChild;
  final bool? isLoading;
  final bool? isDelete;
  final bool? isUpdate;
  final String? errorMessageApi;
  final PictogramAchievements? pictogram;
  final Map<String, String?> validationErrors;
  final bool? isCreate;

  CustomPictogramState({
    this.idChild = 0,
    this.isLoading,
    this.isDelete,
    this.isUpdate,
    this.errorMessageApi,
    this.pictogram,
    this.isCreate = false,
    this.validationErrors = const {},
  });

  CustomPictogramState copyWith({
    int? idChild,
    bool? isLoading,
    bool? isDelete,
    bool? isUpdate,
    String? errorMessageApi,
    PictogramAchievements? pictogram,
    bool? isCreate,
    Map<String, String?>? validationErrors,
  }) =>
      CustomPictogramState(
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        idChild: idChild ?? this.idChild,
        isCreate: isCreate ?? this.isCreate,
        isLoading: isLoading ?? this.isLoading,
        isDelete: isDelete ?? this.isDelete,
        isUpdate: isUpdate ?? this.isUpdate,
        pictogram: pictogram ?? this.pictogram,
        validationErrors: validationErrors ?? this.validationErrors,
      );
}
