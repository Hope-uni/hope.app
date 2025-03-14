import 'package:hope_app/domain/domain.dart';

abstract class ActivitiesRepository {
  Future<ResponseDataList<Activities>> getAllActivities({
    required int indexPage,
  });

  Future<ResponseDataObject<Activity>> createActivity({
    required CreateActivity activity,
  });

  Future<ResponseDataObject<Activity>> getActivity({
    required int idActivity,
  });
}
