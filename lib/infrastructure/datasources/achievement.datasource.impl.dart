import 'package:hope_app/domain/domain.dart'
    show
        AchievementDatasource,
        PictogramAchievements,
        ResponseDataList,
        ResponseDataObject;
import 'package:hope_app/infrastructure/infrastructure.dart'
    show ErrorHandler, PictogramsMapper, ResponseMapper;
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class AchievementDatasourceImpl extends AchievementDatasource {
  final dioServices = DioService();

  @override
  Future<ResponseDataObject<PictogramAchievements>> assignAchievement({
    required int patientId,
    required int achievementId,
  }) async {
    try {
      final response = await dioServices.dio.post(
        '/achievements/assign-achievement',
        data: {$patientIdAchievement: patientId, $achievementId: achievementId},
      );

      final responseAchievement =
          ResponseMapper.responseJsonToEntity<PictogramAchievements>(
              json: response.data,
              fromJson: PictogramsMapper.pictogramAchievementsfromJson);

      return responseAchievement;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataList<PictogramAchievements>> getAchievementByPatient({
    required int indexPage,
    required int idPatient,
  }) async {
    try {
      final response = await dioServices.dio
          .get('/achievements?page=$indexPage&size=15&patientId=$idPatient');

      final responsechievements =
          ResponseMapper.responseJsonListToEntity<PictogramAchievements>(
              json: response.data,
              fromJson: PictogramsMapper.pictogramAchievementsfromJson);

      return responsechievements;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
