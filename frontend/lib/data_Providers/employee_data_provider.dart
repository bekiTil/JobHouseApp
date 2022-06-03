import 'dart:convert';

import 'package:frontend/models/Employee.dart';
import 'package:frontend/models/employee_profile.dart';
import 'package:frontend/repository/repository.dart';
import 'package:frontend/utils/exception.dart';
import 'package:http/http.dart' as http;

class EmployeeDataProvider {
  static Future<dynamic> fetchSingle() async {
    StorageService storage = StorageService();
    final String? id = await storage.getId();
    print(id);
    var url = Uri.parse("http://localhost:3000/api/users/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responded = jsonDecode(response.body);
      EmployeeProfile emp;

      if (responded['profile'].length > 0) {
        emp = EmployeeProfile(
          responded['profile'][0]['fieldOfStudy'],
          responded['profile'][0]['educationLevel'],
          responded['profile'][0]['yearsOfExperience'],
          responded['profile'][0]['location'],
          responded['profile'][0]['bio'],
        );
      } else {
        emp = EmployeeProfile(' ', ' ', 0, ' ', ' ');
      }
      return Employee(
        responded['_id'],
        responded['fullName'],
        responded['username'],
        responded['email'],
        responded['role'],
        emp,
      );
    } else {
      throw AuthException("Couldn't Fetch Data");
    }
  }

  static Future edit(
    String fieldOfStudy,
    String educationLevel,
    int yearsOfExperience,
    String location,
    String bio,
    String token,
    String id,
  ) async {
    Map<String, dynamic> profile = {
      "fieldOfStudy": fieldOfStudy,
      "educationLevel": educationLevel,
      "yearsOfExperience": yearsOfExperience,
      "location": location,
      "bio": bio,
    };
    Map<String, dynamic> data = {'profile': profile};
    print(token);
    final response =
        await http.put(Uri.parse("http://localhost:3000/api/users/$id"),
            headers: {
              "x-auth-token": token,
              "Accept": "application/json",
              "Content-Type": "application/json",
              "Access-Control-Allow-Origin": "*",
              "Access-Control-Allow-Headers": "*",
              "Access-Control-Allow-Methods": "*",
              "Access-Control-Allow-Credentials": "true"
            },
            body: json.encode(data),
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body);
    } else {
      throw AuthException(response.body);
    }
  }

  static Future<dynamic> deleteSingle() async {

    StorageService storage = StorageService();
    final String? id = await storage.getId();
    var url = Uri.parse("http://localhost:3000/api/users/$id");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return; 
    }
    else {
      throw AuthException("Couldn't Delete user");
    }
    
}
}