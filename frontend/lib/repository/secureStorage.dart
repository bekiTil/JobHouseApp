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

    await prefs.clear();
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
