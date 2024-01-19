import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StorageKey {
  token,
}

class AppStorage {

  static const _storage = FlutterSecureStorage();

  static Future<String?> read(StorageKey key) async {
    final value = await _storage.read(key: key.name);
    return value;
  }

  static Future<void> write(StorageKey key, String value) async {
    await _storage.write(key: key.name, value: value);
  }

  static Future<void> clearAllData() async {
    await _storage.deleteAll();
  }
}
