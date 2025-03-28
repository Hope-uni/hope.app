import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class PhaseShiftMapper {
  static PhaseShift phaseShiftfromJson(Map<String, dynamic> json) => PhaseShift(
        currentPhase:
            CatalogoObjectMapper.catalogObjectfromJson(json["currentPhase"]),
        progress: ProgressMapper.progressfromJson(json["progress"]),
      );
}
