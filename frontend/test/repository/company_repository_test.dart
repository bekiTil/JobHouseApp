import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:flutter/material.dart';

void main() {
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
        File('test/repository/test_resources/random_login_response.json')
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
