import 'package:hope_app/domain/domain.dart';
import 'package:hope_app/infrastructure/infrastructure.dart';

class KeyValueStorageRepositoryImpl extends KeyValueStorageRepository {
  final KeyValueStorageDataSource keyStorageDataSource;

  KeyValueStorageRepositoryImpl(
      {KeyValueStorageDataSource? keyStorageDataSource})
      : keyStorageDataSource =
            keyStorageDataSource ?? KeyValueStorageDataSourceImpl();

  @override
  Future<bool> deleteKeyStorage(String key) async {
    return keyStorageDataSource.deleteKeyStorage(key);
  }

  @override
  Future<T?> getValueStorage<T>(String key) async {
    return keyStorageDataSource.getValueStorage(key);
  }

  @override
  Future<void> setValueStorage<T>(T value, String key) async {
    return keyStorageDataSource.setValueStorage(value, key);
  }
}
