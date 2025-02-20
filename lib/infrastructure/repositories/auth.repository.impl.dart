import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({AuthDataSource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<ResponseDataObject<Token>> login(
      String emailUsername, String password) {
    return dataSource.login(emailUsername, password);
  }

  @override
  Future<ResponseDataObject> forgotPassword(String emailOrUserName) {
    return dataSource.forgotPassword(emailOrUserName);
  }

  @override
  Future<ResponseDataObject<Me>> mePermissions() {
    return dataSource.mePermissions();
  }
}
