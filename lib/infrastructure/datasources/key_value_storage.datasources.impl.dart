import 'package:hope_app/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageDataSourceImpl extends KeyValueStorageDataSource {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> deleteKeyStorage(String key) async {
    final prefs = await getSharedPrefs();
    return prefs.remove(key);
  }

  @override
  Future<T?> getValueStorage<T>(String key) async {
    final prefs = await getSharedPrefs();

    if (T == int) return prefs.getInt(key) as T?;
    if (T == String) return prefs.getString(key) as T?;
    if (T == bool) return prefs.getBool(key) as T?;
    if (T == double) return prefs.getDouble(key) as T?;
    if (T == List<String>) return prefs.getStringList(key) as T?;
    throw UnimplementedError('No se implemento el tipo ${T.runtimeType}');
  }

  @override
  Future<void> setValueStorage<T>(T value, String key) async {
    final prefs = await getSharedPrefs();

    if (T == int) {
      prefs.setInt(key, value as int);
      return;
    }
    if (T == String) {
      prefs.setString(key, value as String);
      return;
    }
    if (T == bool) {
      prefs.setBool(key, value as bool);
      return;
    }
    if (T == double) {
      prefs.setDouble(key, value as double);
      return;
    }
    if (T == List<String>) {
      prefs.setStringList(key, value as List<String>);
      return;
    }
    throw UnimplementedError('No se implemento el tipo ${T.runtimeType}');
  }
}
