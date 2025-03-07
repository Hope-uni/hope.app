import 'package:hope_app/domain/domain.dart';

abstract class PictogramsRepository {
  Future<ResponseDataList<PictogramAchievements>> getPictograms({
    required int indexPage,
  });
}
