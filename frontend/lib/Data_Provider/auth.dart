import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Models/user.dart';

class AuthProvider {
  AuthProvider();

  Future<void> signup(User user) async {
    try {
      final dio = Dio();
      const url = "http://localhost:3000/api/users";
      final map = Map<String, dynamic>();
      map["username"] = user.username;
      map["email"] = user.email;
      map["password"] = user.password;
      map["role"] = user.role;
      map["fullName"] = user.name;

      FormData formData = FormData.fromMap({
        "username": user.username,
        "email": user.email,
        "password": user.password,
        "role": user.role,
        "fullName": user.name,
      });

      final response =
          await dio.post(url, data: formData) as Map<String, dynamic>;
      user.id = response["id"];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> login(String username, String password) async {
    try {
      final dio = Dio();
      const url = "http://localhost:3000/login";
      final response = await dio
          .post(url, data: {"username": username, "password": password});
      if (response.statusCode == 201) {
        return {"token": response.data["token"], "user": response.data["user"]};
      }
    } catch (e) {
      return null;
    }
  }
}
