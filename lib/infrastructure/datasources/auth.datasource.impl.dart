import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/errors/auth_errors.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/enviroment.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  // ignore: avoid_renaming_method_parameters
  Future<ResponseData<Token>> checkAuthStatus(String tokenUser) async {
    try {
      final response = await dio.get('path',
          options: Options(headers: {'Authorization': 'Bearer $tokenUser'}));

      final token = ResponseMapper.responseJsonToEntity<Token>(
          response.data, TokenMapper.tokenJsonToEntity);
      return token;
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<ResponseData<Token>> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'username': email, 'password': password});
      final token = ResponseMapper.responseJsonToEntity<Token>(
          response.data, TokenMapper.tokenJsonToEntity);
      return token;
    } on DioException catch (e) {
      throw CustomError(e.response?.data['message'] ??
          'Lo sentimos, ha ocurrido un error al procesar tu solicitud. Por favor, intenta nuevamente más tarde.');
    } catch (e) {
      throw CustomError(
          'Lamentablemente, ocurrió un error inesperado. Por favor, intenta nuevamente más tarde.');
    }
  }

  @override
  Future<ResponseData<Token>> resetPassword(String emailOrUserName) {
    throw UnimplementedError();
  }
}
