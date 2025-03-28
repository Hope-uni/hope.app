import 'package:hope_app/domain/domain.dart';

abstract class PhaseRepository {
  Future<ResponseDataList<Phase>> getPhases();
  Future<ResponseDataObject<PhaseShift>> changePhase({required int idChild});
}
