import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:toastification/toastification.dart';

class ChildrenDataSourceImpl extends ChildrenDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataList<Children>> getChildrenTherapist(
      {required int page}) async {
    try {
      final response =
          await dioServices.dio.get('/therapist/patients?page=$page&size=15');

      final responseChildren =
          ResponseMapper.responseJsonListToEntity<Children>(
              json: response.data,
              fromJson: ChildrenMapper.childrenJsonToEntity);

      return responseChildren;
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
  Future<ResponseDataList<Children>> getChildrenTutor(
      {required int page}) async {
    try {
      final response =
          await dioServices.dio.get('/tutor/patients?page=$page&size=15');

      final responseChildren =
          ResponseMapper.responseJsonListToEntity<Children>(
              json: response.data,
              fromJson: ChildrenMapper.childrenJsonToEntity);

      return responseChildren;
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
  Future<ResponseDataObject<Child>> getChild({required int idChild}) async {
    try {
      final response = await dioServices.dio.get('/patient/$idChild');

      final responseChild = ResponseMapper.responseJsonToEntity<Child>(
          json: response.data, fromJson: ChildMapper.childfromJson);

      return responseChild;
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
  Future<ResponseDataObject<Person>> updateChild({
    required int idChild,
    required Person child,
  }) async {
    try {
      final data = PersonMapper.personToJson(child);
      data.removeWhere((key, value) => value == null);

      final response =
          await dioServices.dio.put('/patient/$idChild', data: data);

      final responseChild = ResponseMapper.responseJsonToEntity<Person>(
          json: response.data, fromJson: PersonMapper.personFromJson);

      return responseChild;
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
  Future<ResponseDataObject<Observation>> createObservation({
    required int idChild,
    required String description,
  }) async {
    try {
      final response =
          await dioServices.dio.post('/observation/id-patient', data: {
        $patientId: idChild,
        $descriptionChild: description,
      });

      final responseObservation =
          ResponseMapper.responseJsonToEntity<Observation>(
              json: response.data,
              fromJson: ObservationMapper.observationfromJson);

      return responseObservation;
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
