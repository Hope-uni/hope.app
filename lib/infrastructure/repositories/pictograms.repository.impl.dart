import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class PictogramsRepositoyImpl extends PictogramsRepository {
  final PictogramsDataSource dataSource;

  PictogramsRepositoyImpl({PictogramsDataSource? dataSource})
      : dataSource = dataSource ?? PictogramsDataSourceImpl();

  @override
  Future<ResponseDataList<PictogramAchievements>> getPictograms({
    required int indexPage,
  }) {
    return dataSource.getPictograms(indexPage: indexPage);
  }
}
