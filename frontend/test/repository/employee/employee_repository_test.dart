import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/employee_profile.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'mock_employee_data_provider.dart';

void main() {
  group('Employee Profile Repository test', () {
    test('requiest for fetching a single user', () async {
      Future<http.Response> _mockGetRequest(http.Request request) async {
        return http.Response(
            File('test/repository/employee/test_resources/random_employee.json')
                .readAsStringSync(),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }

      final mockEmployeeDataProvider =
          MockEmployeeDataProvider(MockClient(_mockGetRequest));
      final user = await mockEmployeeDataProvider.getUser();
      EmployeeProfile emp = user.employeeProfile;
      expect(user.id, "fakeID");
      expect(user.fullName, "First Last");
      expect(user.username, "fakeUserName");
      expect(user.email, "fakeEmail@gmail.com");
      expect(user.role, 'company');
      expect(emp.fieldOfStudy, "Software");
      expect(emp.educationLevel, "3");
      expect(emp.yearsOfExperience, 2);
      expect(emp.location, "Addis Ababa");
      expect(emp.bio, 'some description');
    });

    test('test editing an employee profile', () async {
      Future<http.Response> _mockEditRequest(http.Request request) async {
        final newFile = jsonDecode(request.body) as Map<String, dynamic>;
        Map<String, dynamic> editedFile = {
          "fieldOfStudy": newFile['fieldOfStudy'],
          "educationLevel": newFile['educationLevel'],
          "yearsOfExperience": newFile['yearsOfExperience'],
          "location": newFile['location'],
          "bio": newFile['bio']
        };
        return http.Response(
          json.encode(editedFile),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        );
      }

      final newcompanyProfile = {
        'fieldOfStudy': "Software",
        'educationLevel': "3",
        'yearsOfExperience': 2,
        'location': "Adama",
        'bio': "new bio",
      };
      final mockEmployeeDataProvider =
          MockEmployeeDataProvider(MockClient(_mockEditRequest));
      final user = await mockEmployeeDataProvider.editUser(newcompanyProfile);
      expect(user.location, 'Adama');
      expect(user.bio, 'new bio');
    });

    test('test deleting a company Profile', () async {
      Future<http.Response> _mockDeleteRequest(http.Request request) async {
        return http.Response("Deleted Successfully", 200, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }

      final mockCompanyDataProvider =
          MockCompanyDataProvider(MockClient(_mockDeleteRequest));

      final http.Response response =
          await mockCompanyDataProvider.deleteUser('1');
      expect(response.statusCode, 200);
    });
  });

  test("The model should be able to recieve the following data", () {
    final user = Company(
      "12",
      "First Last",
      "fakeUsername",
      'fakeEmail@gmail.com',
      'company',
      CompanyProfile('Addis Ababa', 'some description'),
    );

    CompanyProfile cmp = user.companyProfile;
    expect(user.id, "12");
    expect(user.fullName, "First Last");
    expect(user.username, "fakeUsername");
    expect(user.email, "fakeEmail@gmail.com");
    expect(user.role, 'company');
    expect(cmp.location, "Addis Ababa");
    expect(cmp.bio, 'some description');
  });

  test("", () {
    final fakeData =
        File('test/repository/auth/test_resources/random_login_response.json')
            .readAsStringSync();
    final json = jsonDecode(fakeData);
    final user = Company.fromJson(json['user']);
    CompanyProfile cmp = user.companyProfile;
    expect(user.id, "fakeID");
    expect(user.fullName, "First Last");
    expect(user.username, "fakeUserName");
    expect(user.email, "fakeEmail@gmail.com");
    expect(user.role, 'company');
    expect(cmp.location, "Addis Ababa");
    expect(cmp.bio, 'some description');
  });
}
