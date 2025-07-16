import 'package:hope_app/domain/domain.dart';

abstract class ActivitiesDataSource {
  Future<ResponseDataList<Activities>> getAllActivities({
    required int indexPage,
  });

  Future<ResponseDataObject<Activity>> createActivity({
    required CreateActivity activity,
  });

  Future<ResponseDataObject<Activity>> getActivity({
    required int idActivity,
  });

  Future<ResponseDataObject<ResponseData>> deleteActivity({
    required int idActivity,
  });

  Future<ResponseDataObject<ResponseData>> assingActivity({
    required int idActivity,
    required List<int> idsPatients,
  });

  Future<ResponseDataObject<ResponseData>> unassingActivity({
    required int idChild,
  });

  Future<ResponseDataObject<CurrentCompletedActivity>> checkAnswer({
    required int idActivity,
    required List<int> idSolutions,
  });

  Future<ResponseDataObject<PatientActivity>> currentActivity();
}
