import 'package:hope_app/domain/domain.dart';

abstract class PictogramsRepository {
  Future<ResponseDataList<PictogramAchievements>> getPictograms({
    required int indexPage,
    required int? idCategory,
    required String? namePictogram,
  });

  Future<ResponseDataList<Category>> getCategoryPictograms();

  Future<ResponseDataObject<PictogramAchievements>> createCustomPictogram({
    required CustomPictogram customPictogram,
  });

  Future<ResponseDataList<PictogramAchievements>> getCustomPictograms({
    required int indexPage,
    required int idChild,
    required int? idCategory,
    required String? namePictogram,
  });

  Future<ResponseDataObject<ResponseData>> deleteCustomPictograms({
    required int idPictogram,
    required int idChild,
  });

  Future<ResponseDataObject<PictogramAchievements>> updateCustomPictograms({
    required CustomPictogram pictogram,
    required int idPictogram,
  });

  Future<ResponseDataList<PictogramAchievements>> getPictogramsPatient({
    required int indexPage,
    required int? idCategory,
  });
}
