import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:toastification/toastification.dart';

class PictogramsDataSourceImpl extends PictogramsDataSource {
  final dioServices = DioService();
  @override
  Future<ResponseDataList<PictogramAchievements>> getPictograms({
    required int indexPage,
  }) async {
    try {
      final response =
          await dioServices.dio.get('/pictogram/?page=$indexPage&size=15');

      final responsePictograms =
          ResponseMapper.responseJsonListToEntity<PictogramAchievements>(
              json: response.data,
              fromJson: PictogramsMapper.pictogramAchievementsfromJson);

      return responsePictograms;
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
  Future<ResponseDataList<Category>> getCategoryPictograms() async {
    try {
      final response = await dioServices.dio.get('/category');

      final responseCategoryPictograms =
          ResponseMapper.responseJsonListToEntity<Category>(
              json: response.data, fromJson: CategoryMapper.categoryfromJson);

      return responseCategoryPictograms;
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
  Future<ResponseDataObject<PictogramAchievements>> createCustomPictogram(
      {required CustomPictogram customPictogram}) async {
    try {
      final data = CustomPictogramMapper.toJson(customPictogram);

      final response =
          await dioServices.dio.post('/patientPictogram', data: data);

      final responseCustomPictograms =
          ResponseMapper.responseJsonToEntity<PictogramAchievements>(
        json: response.data,
        fromJson: PictogramsMapper.pictogramAchievementsfromJson,
      );

      return responseCustomPictograms;
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
  Future<ResponseDataList<PictogramAchievements>> getCustomPictograms({
    required int indexPage,
    required int idChild,
  }) async {
    try {
      final response = await dioServices.dio.get(
          '/patientPictogram/patient-pictograms/$idChild?page=$indexPage&size=15');

      final responseCustomPictograms =
          ResponseMapper.responseJsonListToEntity<PictogramAchievements>(
        json: response.data,
        fromJson: PictogramsMapper.pictogramAchievementsfromJson,
      );

      return responseCustomPictograms;
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
