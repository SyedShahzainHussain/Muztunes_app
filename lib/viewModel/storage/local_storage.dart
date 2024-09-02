import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final localStorage = const FlutterSecureStorage();

  Future<bool> setValue(String key, String value) async {
    await localStorage.write(key: key, value: value);
    return true;
  }

  Future<dynamic> realValue(String key) async {
    return await localStorage.read(key: key);
  }

  Future<bool> clearValue(String key) async {
    await localStorage.delete(key: key);
    return true;
  }
}