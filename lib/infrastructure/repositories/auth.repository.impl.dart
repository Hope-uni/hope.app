import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({AuthDataSource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<ResponseDataObject<Token>> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<ResponseDataObject<Token>> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<ResponseDataObject<Token>> resetPassword(String emailOrUserName) {
    return dataSource.resetPassword(emailOrUserName);
  }
}
