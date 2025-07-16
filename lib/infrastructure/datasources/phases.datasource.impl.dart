import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';

class PhasesDataSourceImpl extends PhasesDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataList<Phase>> getPhases() async {
    try {
      final response = await dioServices.dio.get('/phase');

      final responsePhases = ResponseMapper.responseJsonListToEntity<Phase>(
          json: response.data, fromJson: PhaseMapper.fromJsonPhase);

      return responsePhases;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<PhaseShift>> changePhase({
    required int idChild,
  }) async {
    try {
      final response = await dioServices.dio.put('/phase/phase-shift/$idChild');

      final responsePhase = ResponseMapper.responseJsonToEntity<PhaseShift>(
          json: response.data, fromJson: PhaseShiftMapper.phaseShiftfromJson);

      return responsePhase;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
