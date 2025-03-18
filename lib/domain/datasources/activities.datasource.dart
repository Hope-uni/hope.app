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
}
