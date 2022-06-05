import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'mock_company_data_provider.dart';

void main() {
  group('Company Profile Repository test', () {
    test('requiest for fetching a single user', () async {
      Future<http.Response> _mockGetRequest(http.Request request) async {
        return http.Response(
            File('test/repository/company/test_resources/random_company.json')
                .readAsStringSync(),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }

      final mockCompanyDataProvider =
          MockCompanyDataProvider(MockClient(_mockGetRequest));
      final user = await mockCompanyDataProvider.getUser();
      CompanyProfile cmp = user.companyProfile;
      expect(user.id, "fakeID");
      expect(user.fullName, "First Last");
      expect(user.username, "fakeUserName");
      expect(user.email, "fakeEmail@gmail.com");
      expect(user.role, 'company');
      expect(cmp.location, "Addis Ababa");
      expect(cmp.bio, 'some description');
    });

    test('test editing a company repostitory', () async {
      Future<http.Response> _mockEditRequest(http.Request request) async {
        final newFile = jsonDecode(request.body) as Map<String, dynamic>;
        Map<String, dynamic> editedFile = {
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

      final newcompanyProfile = {'location': "Adama", 'bio': "new bio"};
      final mockCompanyDataProvider =
          MockCompanyDataProvider(MockClient(_mockEditRequest));
      final user = await mockCompanyDataProvider.editUser(newcompanyProfile);
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
