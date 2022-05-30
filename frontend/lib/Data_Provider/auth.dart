import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../Models/user.dart';

class AuthProvider {
  AuthProvider();

  Future<void> signup(User user) async {
    try {
      var url = Uri.parse('http://localhost:3000/api/users');

      final response = await http.post(url, body: {
        "username": user.username,
        "email": user.email,
        "password": user.password,
        "role": user.role,
        "fullName": user.name,
      });
      print(response.body);
      var responded = convert.jsonDecode(response.body);
      print(user);

      user.id = responded["_id"];
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> login(String username, String password) async {
    try {
      var url = Uri.parse("http://localhost:3000/login");
      final response = await http
          .post(url, body: {"username": username, "password": password});

      if (response.statusCode == 201) {
        var responded =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(responded["user"]["username"]);
        return {"token": responded["token"], "user": responded["user"]};
      }
    } catch (e) {
      return null;
    }
  }
}
