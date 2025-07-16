import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/services/services.dart';
import 'package:hope_app/presentation/utils/utils.dart';

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
    } catch (e) {
      ErrorHandler.handleError(e);
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
    } catch (e) {
      ErrorHandler.handleError(e);
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
    } catch (e) {
      ErrorHandler.handleError(e);
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
    } catch (e) {
      ErrorHandler.handleError(e);
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
    } catch (e) {
      ErrorHandler.handleError(e);
    }
  }
}
