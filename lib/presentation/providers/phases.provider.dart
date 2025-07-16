import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

final phasesProvider =
    StateNotifierProvider.autoDispose<PhasesNotifier, PhaseState>((ref) {
  return PhasesNotifier(phaseRepository: PhasesRepositoryImpl());
});

class PhasesNotifier extends StateNotifier<PhaseState> {
  final PhasesRepositoryImpl phaseRepository;

  PhasesNotifier({required this.phaseRepository}) : super(PhaseState());

  Future<void> getPhases({required bool isPermission}) async {
    state = state.copyWith(isLoading: true);
    if (isPermission == false) {
      state = state.copyWith(isLoading: false);
      return;
    }
    try {
      final phases = await phaseRepository.getPhases();

      state = state.copyWith(
        phases: phases.data!,
        isLoading: false,
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
    }
  }

  Future<PhaseShift?> changePhase({required int idChild}) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await phaseRepository.changePhase(idChild: idChild);

      state = state.copyWith(
        isLoading: false,
        isUpdate: true,
        newPhase: response.data!.currentPhase.name,
      );
      return response.data;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessageApi: e.message, isLoading: false);
      return null;
    } catch (e) {
      state = state.copyWith(
        errorMessageApi: S.current.Error_inesperado,
        isLoading: false,
      );
      return null;
    }
  }

  void updateResponse() {
    state = state.copyWith(errorMessageApi: '', isUpdate: false, newPhase: '');
  }
}

class PhaseState {
  final List<Phase> phases;
  final String? newPhase;
  final bool? isLoading;
  final bool? isUpdate;
  final String? errorMessageApi;

  PhaseState({
    this.phases = const [],
    this.isLoading = false,
    this.isUpdate = false,
    this.errorMessageApi,
    this.newPhase,
  });

  PhaseState copyWith({
    List<Phase>? phases,
    bool? isLoading,
    bool? isUpdate,
    String? errorMessageApi,
    String? newPhase,
  }) =>
      PhaseState(
        phases: phases ?? this.phases,
        newPhase: newPhase == '' ? null : newPhase ?? this.newPhase,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
