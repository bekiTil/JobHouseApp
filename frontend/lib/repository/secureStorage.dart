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
  Future<String?> getId() async {
    return await _secureStorage.read(key: "id");
  }

  Future<String?> getRole() async {
    return await _secureStorage.read(key: "role");
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: "token");
  }
}
// import 'package:shared_preferences/shared_preferences.dart';

// class StorageService {
//   final _prefs = SharedPreferences.getInstance();

//   Future<void> saveIdAndToken(String role, String id, String token) async {
//     print(id);
//     SharedPreferences prefs = await _prefs;

//     await prefs.setString('role', role);
//     await prefs.setString("id", id);
//     await prefs.setString("token", token);
//   }

//   Future<bool> hasToken() async {
//     SharedPreferences prefs = await _prefs;

//     var value = prefs.getString("token");

//     return value != null;
//   }

//   Future<void> deleteAll() async {
//     SharedPreferences prefs = await _prefs;

//     prefs.remove('token');
//     prefs.remove('id');
//     prefs.remove('role');
//   }

//   Future<String?> getId() async {
//     SharedPreferences prefs = await _prefs;

//     return prefs.getString("id");
//   }

//   Future<String?> getRole() async {
//     SharedPreferences prefs = await _prefs;
//     return prefs.getString("role");
//   }

//   Future<String?> getToken() async {
//     SharedPreferences prefs = await _prefs;
//     return prefs.getString("token");
//   }
// }
