import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class PhasesRepositoryImpl extends PhaseRepository {
  final PhasesDataSource dataSource;

  PhasesRepositoryImpl({PhasesDataSource? dataSource})
      : dataSource = dataSource ?? PhasesDataSourceImpl();

  @override
  Future<ResponseDataList<Phase>> getPhases() {
    return dataSource.getPhases();
  }

  @override
  Future<ResponseDataObject<PhaseShift>> changePhase({required int idChild}) {
    return dataSource.changePhase(idChild: idChild);
  }
}
