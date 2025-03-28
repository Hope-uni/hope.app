import 'package:hope_app/domain/domain.dart';

abstract class PhasesDataSource {
  Future<ResponseDataList<Phase>> getPhases();
  Future<ResponseDataObject<PhaseShift>> changePhase({required int idChild});
}
