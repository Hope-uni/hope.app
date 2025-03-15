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
}
