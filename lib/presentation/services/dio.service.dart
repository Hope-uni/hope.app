import 'package:dio/dio.dart';
import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';
import 'package:hope_app/presentation/utils/utils.dart';

class DioService {
  // Declara una instancia estática y final de DioService
  static final DioService _singleton = DioService._internal();

  // El Dio que se usará para hacer las peticiones
  late Dio dio;
  final KeyValueStorageRepository keyValueRepository =
      KeyValueStorageRepositoryImpl();

  // Constructor de fábrica que devuelve la misma instancia
  factory DioService() {
    return _singleton;
  }

  // Constructor privado que inicializa la instancia
  DioService._internal() {
    configureBearer();
  }

  // Configura el token de autorización
  Future<void> configureBearer() async {
    final String? token =
        await keyValueRepository.getValueStorage<String>('token');
    dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

    if (token != null) {
      dio.options.headers['Content-type'] = "application/json";
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
