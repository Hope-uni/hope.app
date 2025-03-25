import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:hope_app/presentation/utils/utils.dart';
import 'package:toastification/toastification.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dioServices = DioService();

  @override
  Future<ResponseDataObject<Token>> login(
    String emailUsername,
    String password,
  ) async {
    try {
      final response = await dioServices.dio.post('/auth/login',
          data: {$emailUsername: emailUsername, $password: password});

      final token = ResponseMapper.responseJsonToEntity<Token>(
          json: response.data, fromJson: TokenMapper.tokenJsonToEntity);

      return token;
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
  Future<ResponseDataObject<ResponseData>> forgotPassword(
    String emailOrUserName,
  ) async {
    try {
      final response = await dioServices.dio.post('/auth/forgot-password',
          data: {$emailUsername: emailOrUserName});

      final responseForgotPassword =
          ResponseMapper.responseJsonToEntity<ResponseData>(
              json: response.data);

      return responseForgotPassword;
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
  Future<ResponseDataObject<Me>> mePermissions() async {
    try {
      final response = await dioServices.dio.get('/auth/me');

      final responseMe = ResponseMapper.responseJsonToEntity<Me>(
          json: response.data,
          fromJson: MePermissionsMapper.mePermissionsJsonToEntity);

      return responseMe;
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
  Future<ResponseDataObject<ResponseData>> changePassword({
    required ChangePassword passwords,
  }) async {
    try {
      final data = ChangePasswordMapper.toJson(passwords);
      final response =
          await dioServices.dio.post('/auth/change-password', data: data);

      final responseChangePassword =
          ResponseMapper.responseJsonToEntity<ResponseData>(
              json: response.data);

      return responseChangePassword;
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
  Future<ResponseDataObject<ResponseData>> changePasswordChild({
    required ChangePassword passwordsChild,
    required int idChild,
  }) async {
    try {
      final data = ChangePasswordMapper.toJson(passwordsChild);
      final response = await dioServices.dio.put('/auth/$idChild', data: data);

      final responseChangePassword =
          ResponseMapper.responseJsonToEntity<ResponseData>(
              json: response.data);

      return responseChangePassword;
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
