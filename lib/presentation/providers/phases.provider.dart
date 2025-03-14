import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

final phasesProvider = StateNotifierProvider<PhasesNotifier, PhaseState>((ref) {
  final phasesDatasource = PhasesDataSourceImpl();
  return PhasesNotifier(phaseDatasource: phasesDatasource);
});

class PhasesNotifier extends StateNotifier<PhaseState> {
  final PhasesDataSourceImpl phaseDatasource;

  PhasesNotifier({required this.phaseDatasource}) : super(PhaseState());

  Future<void> getPhases() async {
    state = state.copyWith(isLoading: true);
    try {
      final phases = await phaseDatasource.getPhases();

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

  void updateErrorMessage() {
    state = state.copyWith(errorMessageApi: '');
  }

  void resetState() {
    state = PhaseState();
  }
}

class PhaseState {
  final List<Phase> phases;
  final bool? isLoading;
  final String? errorMessageApi;

  PhaseState({
    this.phases = const [],
    this.isLoading = true,
    this.errorMessageApi,
  });

  PhaseState copyWith({
    List<Phase>? phases,
    bool? isLoading,
    String? errorMessageApi,
  }) =>
      PhaseState(
        phases: phases ?? this.phases,
        errorMessageApi: errorMessageApi == ''
            ? null
            : errorMessageApi ?? this.errorMessageApi,
        isLoading: isLoading ?? this.isLoading,
      );
}
