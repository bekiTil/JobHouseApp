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

      FormData formData = FormData.fromMap({
        "username": user.username,
        "email": user.email,
        "password": user.password,
        "role": user.role,
        "fullName": user.name,
      });

      final response = await dio.post(url, data: formData);
      user.id = response.data["id"];
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
      print(response);
      if (response.statusCode == 201) {
        print(response.data["user"]["username"]);
        return {"token": response.data["token"], "user": response.data["user"]};
      }
    } catch (e) {
      return null;
    }
  }
}
