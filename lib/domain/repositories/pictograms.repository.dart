import 'package:hope_app/domain/domain.dart';

abstract class PictogramsRepository {
  Future<ResponseDataList<PictogramAchievements>> getPictograms({
    required int indexPage,
  });

  Future<ResponseDataList<Category>> getCategoryPictograms();

  Future<ResponseDataObject<PictogramAchievements>> createCustomPictogram({
    required CustomPictogram customPictogram,
  });

  Future<ResponseDataList<PictogramAchievements>> getCustomPictograms({
    required int indexPage,
    required int idChild,
  });

  Future<ResponseDataObject<ResponseData>> deleteCustomPictograms({
    required int idPictogram,
    required int idChild,
  });
}
