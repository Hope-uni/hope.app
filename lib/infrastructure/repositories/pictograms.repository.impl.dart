import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class PictogramsRepositoyImpl extends PictogramsRepository {
  final PictogramsDataSource dataSource;

  PictogramsRepositoyImpl({PictogramsDataSource? dataSource})
      : dataSource = dataSource ?? PictogramsDataSourceImpl();

  @override
  Future<ResponseDataList<PictogramAchievements>> getPictograms({
    required int indexPage,
    required int? idCategory,
    required String? namePictogram,
  }) {
    return dataSource.getPictograms(
      indexPage: indexPage,
      idCategory: idCategory,
      namePictogram: namePictogram,
    );
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
    required int? idCategory,
    required String? namePictogram,
  }) {
    return dataSource.getCustomPictograms(
      indexPage: indexPage,
      idChild: idChild,
      idCategory: idCategory,
      namePictogram: namePictogram,
    );
  }

  @override
  Future<ResponseDataObject<ResponseData>> deleteCustomPictograms({
    required int idPictogram,
    required int idChild,
  }) {
    return dataSource.deleteCustomPictograms(
      idPictogram: idPictogram,
      idChild: idChild,
    );
  }

  @override
  Future<ResponseDataObject<PictogramAchievements>> updateCustomPictograms({
    required CustomPictogram pictogram,
    required int idPictogram,
  }) {
    return dataSource.updateCustomPictograms(
      pictogram: pictogram,
      idPictogram: idPictogram,
    );
  }

  @override
  Future<ResponseDataList<PictogramAchievements>> getPictogramsPatient({
    required int indexPage,
    required int? idCategory,
  }) {
    return dataSource.getPictogramsPatient(
      idCategory: idCategory,
      indexPage: indexPage,
    );
  }
}
