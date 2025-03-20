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

  @override
  Future<ResponseDataList<Category>> getCategoryPictograms() {
    return dataSource.getCategoryPictograms();
  }

  @override
  Future<ResponseDataObject<PictogramAchievements>> createCustomPictogram({
    required CustomPictogram customPictogram,
  }) {
    return dataSource.createCustomPictogram(customPictogram: customPictogram);
  }

  @override
  Future<ResponseDataList<PictogramAchievements>> getCustomPictograms({
    required int indexPage,
    required int idChild,
  }) {
    return dataSource.getCustomPictograms(
      indexPage: indexPage,
      idChild: idChild,
    );
  }
}
