import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:toastification/toastification.dart';

class ProfilePersonDataSourceImpl extends ProfilePersonDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataObject<ProfilePerson>> updateProfileTherapist(
      ProfilePerson profilePerson) async {
    try {
      final response = await dioServices.dio.put(
          '/therapist/${profilePerson.id}',
          data: ProfilePersonMapper.toJson(profilePerson));

      final responseMapper = ResponseMapper.responseJsonToEntity<ProfilePerson>(
        json: response.data,
        fromJson: ProfilePersonMapper.profilePersonJsonToEntity,
      );

      return responseMapper;
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
  Future<ResponseDataObject<ProfilePerson>> updateProfileTutor(
      ProfilePerson profilePerson) async {
    try {
      final response = await dioServices.dio.put('/tutor/${profilePerson.id}',
          data: ProfilePersonMapper.toJson(profilePerson));

      final responseMapper = ResponseMapper.responseJsonToEntity<ProfilePerson>(
        json: response.data,
        fromJson: ProfilePersonMapper.profilePersonJsonToEntity,
      );

      return responseMapper;
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
