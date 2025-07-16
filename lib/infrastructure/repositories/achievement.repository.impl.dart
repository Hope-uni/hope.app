import 'package:hope_app/domain/domain.dart'
    show
        AchievementDatasource,
        AchievementRepository,
        PictogramAchievements,
        ResponseDataList,
        ResponseDataObject;
import 'package:hope_app/infrastructure/infrastructure.dart'
    show AchievementDatasourceImpl;

class AchievementRespositoryImpl extends AchievementRepository {
  final AchievementDatasource dataSource;

  AchievementRespositoryImpl({AchievementDatasource? dataSource})
      : dataSource = dataSource ?? AchievementDatasourceImpl();

  @override
  Future<ResponseDataObject<PictogramAchievements>> assignAchievement({
    required int patientId,
    required int achievementId,
  }) {
    return dataSource.assignAchievement(
      patientId: patientId,
      achievementId: achievementId,
    );
  }

  @override
  Future<ResponseDataList<PictogramAchievements>> getAchievementByPatient({
    required int indexPage,
    required int idPatient,
  }) {
    return dataSource.getAchievementByPatient(
      indexPage: indexPage,
      idPatient: idPatient,
    );
  }
}
