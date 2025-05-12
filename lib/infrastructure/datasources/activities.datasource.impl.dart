import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class ActivitiesDataSourceImpl extends ActivitiesDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataList<Activities>> getAllActivities({
    required int indexPage,
  }) async {
    try {
      final response =
          await dioServices.dio.get('/activity?page=$indexPage&size=15');

      final responseActivities =
          ResponseMapper.responseJsonListToEntity<Activities>(
              json: response.data,
              fromJson: ActivitiesMapper.activitiesFromJson);

      return responseActivities;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<Activity>> createActivity({
    required CreateActivity activity,
  }) async {
    try {
      final data = ActivityMapper.toJsonActivity(activity);

      final response = await dioServices.dio.post('/activity', data: data);

      final responseActivity = ResponseMapper.responseJsonToEntity<Activity>(
          json: response.data, fromJson: ActivityMapper.fromJsonActivity);

      return responseActivity;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<Activity>> getActivity({
    required int idActivity,
  }) async {
    try {
      final response = await dioServices.dio.get('/activity/$idActivity');

      final responseActivity = ResponseMapper.responseJsonToEntity<Activity>(
          json: response.data, fromJson: ActivityMapper.fromJsonActivity);

      return responseActivity;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<ResponseData>> deleteActivity({
    required int idActivity,
  }) async {
    try {
      final response = await dioServices.dio.delete('/activity/$idActivity');

      final responseActivity =
          ResponseMapper.responseJsonToEntity<ResponseData>(
              json: response.data);

      return responseActivity;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<ResponseData>> assingActivity({
    required int idActivity,
    required List<int> idsPatients,
  }) async {
    try {
      final response = await dioServices.dio.post('/activity/assign',
          data: {$patients: idsPatients, $activityId: idActivity});

      final responseAssing = ResponseMapper.responseJsonToEntity<ResponseData>(
          json: response.data);

      return responseAssing;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<ResponseData>> unassingActivity({
    required int idChild,
  }) async {
    try {
      final response = await dioServices.dio
          .post('/activity/unassign', data: {$patientIdActivity: idChild});

      final responseUnassing =
          ResponseMapper.responseJsonToEntity<ResponseData>(
              json: response.data);

      return responseUnassing;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<CurrentCompletedActivity>> checkAnswer(
      {required int idActivity, required List<int> idSolutions}) async {
    try {
      final response = await dioServices.dio.post(
        '/activity/check',
        data: {$activityId: idActivity, $attempt: idSolutions},
      );

      final responseCheckAnswer =
          ResponseMapper.responseJsonToEntity<CurrentCompletedActivity>(
              json: response.data,
              fromJson: CurrentCompletedActivityMapper
                  .currentCompletedActivityfromJson);

      return responseCheckAnswer;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }

  @override
  Future<ResponseDataObject<PatientActivity>> currentActivity() async {
    try {
      final response = await dioServices.dio.get('/activity/current-activity');

      final responsePatientActivity =
          ResponseMapper.responseJsonToEntity<PatientActivity>(
              json: response.data,
              fromJson: PatientActivityMapper.patientActivityfromJson);

      return responsePatientActivity;
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
