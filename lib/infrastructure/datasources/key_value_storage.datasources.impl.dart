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

    switch (T) {
      // ignore: type_literal_in_constant_pattern
      case int:
        return prefs.getInt(key) as T?;
      // ignore: type_literal_in_constant_pattern
      case String:
        return prefs.getString(key) as T?;
      // ignore: type_literal_in_constant_pattern
      case bool:
        return prefs.getBool(key) as T?;
      // ignore: type_literal_in_constant_pattern
      case double:
        return prefs.getDouble(key) as T?;
      default:
        throw UnimplementedError('No se implemento el tipo ${T.runtimeType}');
    }
  }

  @override
  Future<void> setValueStorage<T>(T value, String key) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      // ignore: type_literal_in_constant_pattern
      case int:
        prefs.setInt(key, value as int);
        break;
      // ignore: type_literal_in_constant_pattern
      case String:
        prefs.setString(key, value as String);
        break;
      // ignore: type_literal_in_constant_pattern
      case bool:
        prefs.setBool(key, value as bool);
        break;
      // ignore: type_literal_in_constant_pattern
      case double:
        prefs.setDouble(key, value as double);
        break;
      default:
        throw UnimplementedError('No se implemento el tipo ${T.runtimeType}');
    }
  }
}
