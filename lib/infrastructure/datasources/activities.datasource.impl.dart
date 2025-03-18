import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:toastification/toastification.dart';

class ActivitiesDataSourceImpl extends ActivitiesDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataList<Activities>> getAllActivities(
      {required int indexPage}) async {
    try {
      final response =
          await dioServices.dio.get('/activity?page=$indexPage&size=15');

      final responseActivities =
          ResponseMapper.responseJsonListToEntity<Activities>(
              json: response.data,
              fromJson: ActivitiesMapper.activitiesFromJson);

      return responseActivities;
    } on DioException catch (e) {
      final responseMapper = ResponseMapper.responseJsonToEntity<ResponseData>(
          json: e.response!.data);

      final String message;

      if (responseMapper.validationErrors != null) {
        message = responseMapper.validationErrors!.message;
      } else {
        message = responseMapper.message.isNotEmpty
            ? responseMapper.message
            : S.current.Error_solicitud;
      }

      throw CustomError(
        e.response!.statusCode!,
        message: message,
        typeNotification: ToastificationType.error,
      );
    } catch (e) {
      throw CustomError(
        null,
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
    }
  }

  @override
  Future<ResponseDataObject<Activity>> createActivity(
      {required CreateActivity activity}) async {
    try {
      final data = ActivityMapper.toJsonActivity(activity);

      final response = await dioServices.dio.post('/activity', data: data);

      final responseActivity = ResponseMapper.responseJsonToEntity<Activity>(
          json: response.data, fromJson: ActivityMapper.fromJsonActivity);

      return responseActivity;
    } on DioException catch (e) {
      final responseMapper = ResponseMapper.responseJsonToEntity<ResponseData>(
          json: e.response!.data);

      final String message;

      if (responseMapper.validationErrors != null) {
        message = responseMapper.validationErrors!.message;
      } else {
        message = responseMapper.message.isNotEmpty
            ? responseMapper.message
            : S.current.Error_solicitud;
      }

      throw CustomError(
        e.response!.statusCode!,
        message: message,
        typeNotification: ToastificationType.error,
      );
    } catch (e) {
      throw CustomError(
        null,
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
    }
  }

  @override
  Future<ResponseDataObject<Activity>> getActivity(
      {required int idActivity}) async {
    try {
      final response = await dioServices.dio.get('/activity/$idActivity');

      final responseActivity = ResponseMapper.responseJsonToEntity<Activity>(
          json: response.data, fromJson: ActivityMapper.fromJsonActivity);

      return responseActivity;
    } on DioException catch (e) {
      final responseMapper = ResponseMapper.responseJsonToEntity<ResponseData>(
          json: e.response!.data);

      final String message;

      if (responseMapper.validationErrors != null) {
        message = responseMapper.validationErrors!.message;
      } else {
        message = responseMapper.message.isNotEmpty
            ? responseMapper.message
            : S.current.Error_solicitud;
      }

      throw CustomError(
        e.response!.statusCode!,
        message: message,
        typeNotification: ToastificationType.error,
      );
    } catch (e) {
      throw CustomError(
        null,
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
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
    } on DioException catch (e) {
      final responseMapper = ResponseMapper.responseJsonToEntity<ResponseData>(
          json: e.response!.data);

      final String message;

      if (responseMapper.validationErrors != null) {
        message = responseMapper.validationErrors!.message;
      } else {
        message = responseMapper.message.isNotEmpty
            ? responseMapper.message
            : S.current.Error_solicitud;
      }

      throw CustomError(
        e.response!.statusCode!,
        message: message,
        typeNotification: ToastificationType.error,
      );
    } catch (e) {
      throw CustomError(
        null,
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
    }
  }
}
