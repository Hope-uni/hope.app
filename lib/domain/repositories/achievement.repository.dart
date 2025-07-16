import 'package:hope_app/domain/domain.dart'
    show PictogramAchievements, ResponseDataList, ResponseDataObject;

abstract class AchievementRepository {
  Future<ResponseDataList<PictogramAchievements>> getAchievementByPatient({
    required int indexPage,
    required int idPatient,
  });

  Future<ResponseDataObject<PictogramAchievements>> assignAchievement({
    required int patientId,
    required int achievementId,
  });
}
