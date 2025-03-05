import 'package:hope_app/domain/domain.dart';

abstract class ActivitiesDataSource {
  Future<ResponseDataList<Activities>> getAllActivities({
    required int indexPage,
  });
}
