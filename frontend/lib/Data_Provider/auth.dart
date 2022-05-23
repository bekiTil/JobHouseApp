import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Models/user.dart';

class AuthProvider {
  AuthProvider();

  Future<void> signup(User user) async {
    try {
      final url = Uri.parse("http://localhost:3000/signup");
      FormData formData = FormData.fromMap({
        "username": user.username,
        "email": user.email,
        "password": user.password,
        "role": user.role,
        "name": user.name,
      });
      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          body: formData);
    } catch (e) {
      throw e;
    }
  }
}
