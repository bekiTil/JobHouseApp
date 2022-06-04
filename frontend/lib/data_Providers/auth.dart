import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;

import 'package:frontend/utils/exception.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthProvider {
  AuthProvider();

  Future signup(User user) async {
    var url = Uri.parse('http://10.0.2.2:3000/api/users');

    final response = await http.post(url, body: {
      "username": user.username,
      "email": user.email,
      "password": user.password,
      "role": user.role,
      "fullName": user.fullName,
    });
    print(response.body);
    if (response.statusCode == 200) {
      var responded = convert.jsonDecode(response.body);
      print(user);

      user.id = responded["_id"];
      return user;
    } else {
      throw AuthException(response.body);
    }
  }

  Future<dynamic> login(String username, String password) async {
    Map data = {"username": username, 'password': password};
    var url = Uri.parse("http://10.0.2.2:3000/login");
    final response = await http.post(url, body: data);

    if (response.statusCode == 201) {
      var responded = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(responded["user"]["username"]);
      return {"token": responded["token"], "user": responded["user"]};
    } else {
      throw AuthException("username and password doesn't match");
    }
  }
}
