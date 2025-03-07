import 'package:hope_app/domain/domain.dart';

abstract class PictogramsDataSource {
  Future<ResponseDataList<PictogramAchievements>> getPictograms({
    required int indexPage,
  });
}
