import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const mySecureStorage = FlutterSecureStorage();

  static Future<String?> read(String key) async =>
      await mySecureStorage.read(key: key);

  static Future<void> write(String key, {required String value}) async =>
      await mySecureStorage.write(key: key, value: value);

  static Future<void> delete(String key) async =>
      await mySecureStorage.delete(key: key);
}
