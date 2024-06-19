import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/generated/l10n.dart';
import 'package:toastification/toastification.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dioServices = DioService();
  final KeyValueStorageRepository keyValueRepository =
      KeyValueStorageRepositoryImpl();

  @override
  Future<ResponseDataObject<Token>> checkAuthStatus(String tokenUser) async {
    try {
      final response = await dioServices.dio.get('path',
          options: Options(headers: {'Authorization': 'Bearer $tokenUser'}));

      final token = ResponseMapper.responseJsonToEntity<Token>(
          json: response.data, fromJson: TokenMapper.tokenJsonToEntity);
      return token;
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<ResponseDataObject<Token>> login(
      String emailUsername, String password) async {
    try {
      final response = await dioServices.dio.post('/auth/login',
          data: {'email_username': emailUsername, 'password': password});

      final token = ResponseMapper.responseJsonToEntity<Token>(
          json: response.data, fromJson: TokenMapper.tokenJsonToEntity);

      return token;
    } on DioException catch (e) {
      throw CustomError(
        message: e.response?.data['message'] ?? S.current.Error_solicitud,
        typeNotification: ToastificationType.error,
      );
    } catch (e) {
      throw CustomError(
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
    }
  }

  @override
  Future<ResponseDataObject> forgotPassword(String emailOrUserName) async {
    try {
      final response = await dioServices.dio
          .post('/auth/forgot-password', data: {'username': emailOrUserName});

      final responseForgotPassword =
          ResponseMapper.responseJsonToEntity(json: response.data);

      return responseForgotPassword;
    } on DioException catch (e) {
      throw CustomError(
        message: e.response?.data['message'] ?? S.current.Error_solicitud,
        typeNotification: ToastificationType.error,
      );
    } catch (e) {
      throw CustomError(
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
    }
  }

  @override
  Future<ResponseDataObject<Me>> mePermissions() async {
    try {
      final response = await dioServices.dio.get('/auth/me');

      final responseMe = ResponseMapper.responseJsonToEntity(
          json: response.data,
          fromJson: MePermissionsMapper.mePermissionsJsonToEntity);

      return responseMe;
    } on DioException catch (e) {
      throw CustomError(
        message: e.response?.data['message'] ?? S.current.Error_solicitud,
        typeNotification: ToastificationType.error,
      );
    } catch (e) {
      throw CustomError(
        message: S.current.Error_inesperado,
        typeNotification: ToastificationType.error,
      );
    }
  }
}
