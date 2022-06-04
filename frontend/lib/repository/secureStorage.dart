// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class StorageService {
//   final _secureStorage = const FlutterSecureStorage();

//   Future<void> saveIdAndToken(String role, String id, String token) async {
//     print(id);
//     await _secureStorage.write(key: "role", value: role);
//     await _secureStorage.write(key: "id", value: id);
//     await _secureStorage.write(key: "token", value: token);
//   }

//   Future<bool> hasToken() async {
//     var value = await _secureStorage.read(key: "token");
//     print(value);
//     return value != null;
//   }

//   Future<void> deleteAll() async {
//     return await _secureStorage.deleteAll();
//   }

//   Future<String?> getId() async {
//     return await _secureStorage.read(key: "id");
//   }

//   Future<String?> getRole() async {
//     return await _secureStorage.read(key: "role");
//   }

//   Future<String?> getToken() async {
//     return await _secureStorage.read(key: "token");
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveIdAndToken(String role, String id, String token) async {
    print(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;

    await prefs.setString('role', role);
    await prefs.setString("id", id);
    await prefs.setString("token", token);
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;

    var value = prefs.getString("token");

    return value != null;
  }

  Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;

    await prefs.remove('token');
    await prefs.remove('id');
    await prefs.remove('role');
  }

  Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;
    final String? id = prefs.getString('id');
    return id;
  }

  Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;
    final String? role = prefs.getString("role");
    return role;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ;
    final String? token = prefs.getString("token");
    return token;
  }
}
