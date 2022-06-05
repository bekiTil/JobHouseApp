import 'dart:convert';

import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:http/http.dart';

class MockCompanyDataProvider {
  final Client client;

  MockCompanyDataProvider(this.client);

  final baseUrl = 'http://10.0.2.2:3000/api/users/1';
  Future<Company> getUser() async {
    final response = await client.get(Uri.parse(baseUrl));
    return Company.fromJson(jsonDecode(response.body));
  }

  Future<CompanyProfile> editUser(user) async {
    final response = await client.put(
      Uri.parse(baseUrl),
      body: json.encode(user),
    );
    return CompanyProfile.fromJson(jsonDecode(response.body));
  }

  Future<Response> deleteUser(id) async {
    final response = await client.delete(
      Uri.parse(baseUrl),
    );
    return response;
  }
}
