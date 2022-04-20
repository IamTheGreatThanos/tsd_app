import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late final _storage;

  Future<void> init() async {
    _storage = FlutterSecureStorage();
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    var readData = await _storage.read(key: key);
    return readData;
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
