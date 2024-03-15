abstract class KeyValueStorageDataSource {
  Future<T?> getValueStorage<T>(String key);
  Future<void> setValueStorage<T>(T value, String key);
  Future<bool> deleteKeyStorage(String key);
}
