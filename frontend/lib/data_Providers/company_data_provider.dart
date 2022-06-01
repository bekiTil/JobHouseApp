import 'dart:convert';

import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:frontend/utils/exception.dart';
import 'package:http/http.dart' as http;

class CompanyDataProvider {
  static Future<dynamic> fetchSingle(String id) async {
    var url = Uri.parse("http://localhost:3000/api/users/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responded = jsonDecode(response.body);
      CompanyProfile cmp;

      if (responded['profile'].length > 0) {
        cmp = CompanyProfile(responded['profile'][0]['location'], responded['profile'][0]['bio']);
      }
      else {
        cmp = CompanyProfile(' ', ' ');

      }
      return Company(
        responded['_id'],
        responded['fullName'],
        responded['username'],
        responded['email'],
        responded['role'],
        cmp
      );
    } else {
      throw AuthException("Couldn't Fetch Data");
    }
  }

  static Future edit(String location, String bio, String token, String id) async {
    Map<String, dynamic> profile = {
      "location": location,
      "bio": bio,
    };
    Map<String, dynamic> data = {
      'profile': profile
    };
    print(token);
      final response = await http.put(
          Uri.parse("http://localhost:3000/api/users/$id"),
          headers: {
            "x-auth-token": token.toString(),
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
      }
      else{
        throw AuthException(response.body);
      }
    
  }
}
