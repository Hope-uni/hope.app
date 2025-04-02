import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class ActivitiesRepositoryImpl extends ActivitiesRepository {
  final ActivitiesDataSource dataSource;

  ActivitiesRepositoryImpl({ActivitiesDataSource? dataSource})
      : dataSource = dataSource ?? ActivitiesDataSourceImpl();

  @override
  Future<ResponseDataList<Activities>> getAllActivities(
      {required int indexPage}) {
    return dataSource.getAllActivities(indexPage: indexPage);
  }

  @override
  Future<ResponseDataObject<Activity>> createActivity({
    required CreateActivity activity,
  }) {
    return dataSource.createActivity(activity: activity);
  }

  @override
  Future<ResponseDataObject<Activity>> getActivity({required int idActivity}) {
    return dataSource.getActivity(idActivity: idActivity);
  }

  @override
  Future<ResponseDataObject<ResponseData>> deleteActivity({
    required int idActivity,
  }) {
    return dataSource.deleteActivity(idActivity: idActivity);
  }

  @override
  Future<ResponseDataObject<ResponseData>> assingActivity({
    required int idActivity,
    required List<int> idsPatients,
  }) {
    return dataSource.assingActivity(
      idActivity: idActivity,
      idsPatients: idsPatients,
    );
  }

  @override
  Future<ResponseDataObject<ResponseData>> unassingActivity({
    required int idChild,
  }) {
    return dataSource.unassingActivity(idChild: idChild);
  }
}
