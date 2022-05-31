import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveIdAndToken(String role, String id, String token) async {
    print(id);
    await _secureStorage.write(key: "role", value: role);
    await _secureStorage.write(key: "id", value: id);
    await _secureStorage.write(key: "token", value: token);
  }

  Future<bool> hasToken() async {
    var value = await _secureStorage.read(key: "token");
    print(value);
    return value != null;
  }

  Future<void> deleteAll() async {
    return await _secureStorage.deleteAll();
  }

  Future<String?> getRole() async {
    return _secureStorage.read(key: "role");
  }

  Future<String?> getToken() async {
    return _secureStorage.read(key: "token");
  }
}
