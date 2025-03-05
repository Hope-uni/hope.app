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
}
