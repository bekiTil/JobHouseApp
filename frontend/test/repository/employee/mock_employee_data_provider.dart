import 'dart:convert';

import 'package:frontend/models/Employee.dart';
import 'package:frontend/models/employee_profile.dart';
import 'package:http/http.dart';

class MockEmployeeDataProvider {
  final Client client;

  MockEmployeeDataProvider(this.client);

  final baseUrl = 'http://10.0.2.2:3000/api/users/2';
  Future<Employee> getUser() async {
    final response = await client.get(Uri.parse(baseUrl));
    return Employee.fromJson(jsonDecode(response.body));
  }

  Future<EmployeeProfile> editUser(user) async {
    final response = await client.put(
      Uri.parse(baseUrl),
      body: json.encode(user),
    );
    return EmployeeProfile.fromJson(jsonDecode(response.body));
  }

  Future<Response> deleteUser(id) async {
    final response = await client.delete(
      Uri.parse(baseUrl),
    );
    return response;
  }
}
