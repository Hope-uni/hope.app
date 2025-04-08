import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

final observationProvider = StateNotifierProvider.autoDispose<
    ObservationStateNotifier, ObservationState>((ref) {
  return ObservationStateNotifier(childrenRepository: ChildrenRepositoryImpl());
});

class ObservationStateNotifier extends StateNotifier<ObservationState> {
  final ChildrenRepositoryImpl childrenRepository;

  ObservationStateNotifier({required this.childrenRepository})
      : super(ObservationState());

  Future<Observation?> addObservation({required int idChild}) async {
    state = state.copyWith(isLoading: true);
    try {
      final responseObservation = await childrenRepository.createObservation(
          idChild: idChild, description: state.description!);

      state = state.copyWith(isLoading: false, isCreate: true);
      return responseObservation.data!;
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessageApi: e.message,
        isLoading: false,
      );
      return null;
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
      return null;
    }
  }

  void updateDescription({required String value}) {
    if (value.isNotEmpty) {
      state = state.copyWith(description: value, validationError: '');
    } else {
      state = state.copyWith(description: value);
    }
  }

  bool checkDescription() {
    if (state.description == null ||
        state.description!.isEmpty ||
        state.description!.length < 6) {
      state = state.copyWith(
          validationError: S.current
              .La_descripcion_debe_tener_entre_seis_y_docientocincuentaycinco_caracteres);

      return false;
    } else {
      return true;
    }
  }

  void updateResponse() {
    state = state.copyWith(errorMessageApi: '', isCreate: false);
  }
}

class ObservationState {
  final String? description;
  final bool isLoading;
  final bool isCreate;
  final String? errorMessageApi;
  final String? validationError;

  ObservationState({
    this.description,
    this.isLoading = false,
    this.isCreate = false,
    this.errorMessageApi,
    this.validationError,
  });

  ObservationState copyWith({
    String? description,
    bool? isLoading,
    bool? isCreate,
    String? validationError,
    String? errorMessageApi,
  }) =>
      ObservationState(
        description: description ?? this.description,
        isLoading: isLoading ?? this.isLoading,
        isCreate: isCreate ?? this.isCreate,
        validationError: validationError == ''
            ? null
            : validationError ?? this.validationError,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
      );
}
