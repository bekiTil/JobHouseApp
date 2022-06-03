import 'dart:convert';

import 'package:frontend/data_Providers/local/db_provider.dart';
import 'package:frontend/data_Providers/local/mock_model/com_profile.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:frontend/repository/repository.dart';
import 'package:frontend/utils/exception.dart';
import 'package:http/http.dart' as http;

import 'local/mock_model/merge.dart';

class CompanyDataProvider {
  Future<dynamic> fetchSingle() async {
    StorageService storage = StorageService();
    String? id = await storage.getId();

    // final company = await DBProvider.db.findCompanyById(id!);
    // if (company != null) {
    //   return mergeComProfile(company);
    // }

    var url = Uri.parse("http://localhost:3000/api/users/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responded = jsonDecode(response.body);
      CompanyProfile cmp;

      if (responded['profile'].length > 0) {
        cmp = CompanyProfile(responded['profile'][0]['location'],
            responded['profile'][0]['bio']);
      } else {
        cmp = CompanyProfile(' ', ' ');
      }
      return Company(responded['_id'], responded['fullName'],
          responded['username'], responded['email'], responded['role'], cmp);
    } else {
      throw AuthException("Couldn't Fetch Data");
    }
  }

  Future edit(String location, String bio, String token, String id) async {
    Map<String, dynamic> profile = {
      "location": location,
      "bio": bio,
    };
    Map<String, dynamic> data = {'profile': profile};
    print(token);
    final response =
        await http.put(Uri.parse("http://localhost:3000/api/users/$id"),
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
      //  final employee = await DBProvider.db.findEmployeeById(id);
      // final comValue = MockCompProfile.fromApi(jsonDecode(response.body));
      // if (employee != null) {
      //   final changedProfile =
      //       await DBProvider.db.updateCompanyProfile(comValue);
      // } else {
      //   final changedProfile =
      //       await DBProvider.db.createCompanyProfile(comValue);
      // }
      Map<String, dynamic> user = jsonDecode(response.body);
    } else {
      throw AuthException(response.body);
    }
  }

  static Future deleteSingle(String userName) async {
    StorageService storage = StorageService();
    final String? token = await storage.getToken();

    var url = Uri.parse("http://localhost:3000/api/users/$userName");

    final response = await http.delete(
      url,
      headers: {
        "x-auth-token": token!,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*",
        "Access-Control-Allow-Credentials": "true"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return;
    } else {
      throw AuthException("Couldn't Delete user");
    }
  }
}
