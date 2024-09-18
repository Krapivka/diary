import 'package:shared_preferences/shared_preferences.dart';

abstract class SecretCodeLocalDataSource {
  Future<String?> getPasswordFromCache();
  Future<void> passwordToCache(String password);
  Future<void> removePassword();
}

// ignore: constant_identifier_names
const USER_PASSWORD = 'USER_PASSWORD';

class SecretCodeLocalDataSourceImpl implements SecretCodeLocalDataSource {
  final SharedPreferences sharedPreferences;

  SecretCodeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String?> getPasswordFromCache() async {
    return sharedPreferences.getString(USER_PASSWORD);
  }

  @override
  Future<void> passwordToCache(String password) async {
    await sharedPreferences.setString(USER_PASSWORD, password);
  }

  @override
  Future<void> removePassword() async {
    await sharedPreferences.remove(USER_PASSWORD);
  }
}
