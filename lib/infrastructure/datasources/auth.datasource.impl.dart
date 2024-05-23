import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/enviroment.dart';
import 'package:hope_app/generated/l10n.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<ResponseDataObject<Token>> checkAuthStatus(String tokenUser) async {
    try {
      final response = await dio.get('path',
          options: Options(headers: {'Authorization': 'Bearer $tokenUser'}));

      final token = ResponseMapper.responseJsonToEntity<Token>(
          json: response.data, fromJson: TokenMapper.tokenJsonToEntity);
      return token;
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<ResponseDataObject<Token>> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'username': email, 'password': password});
      final token = ResponseMapper.responseJsonToEntity<Token>(
          json: response.data, fromJson: TokenMapper.tokenJsonToEntity);
      return token;
    } on DioException catch (e) {
      throw CustomError(
        message: e.response?.data['message'] ?? S.current.Error_solicitud,
        statuCode: e.response!.statusCode!,
      );
    } catch (e) {
      throw CustomError(message: S.current.Error_inesperado, statuCode: 501);
    }
  }

  @override
  Future<ResponseDataObject> forgotPassword(String emailOrUserName) async {
    try {
      final response = await dio
          .post('/auth/forgot-password', data: {'username': emailOrUserName});

      final responseForgotPassword =
          ResponseMapper.responseJsonToEntity(json: response.data);

      return responseForgotPassword;
    } on DioException catch (e) {
      throw CustomError(
        message: e.response?.data['message'] ?? S.current.Error_solicitud,
        statuCode: e.response!.statusCode!,
      );
    } catch (e) {
      throw CustomError(message: S.current.Error_inesperado, statuCode: 501);
    }
  }
}
