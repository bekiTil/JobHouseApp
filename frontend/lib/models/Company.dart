import 'dart:convert';

import 'models.dart';

class Company {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String role;
  late CompanyProfile companyProfile;

  Company(this.id, this.fullName, this.username, this.email, this.role,
      this.companyProfile);

  factory Company.fromJson(Map<String, dynamic> json) {
    CompanyProfile cmp = CompanyProfile.fromJson(json['profile']);
    return Company(
      json['id'],
      json['fullName'],
      json['username'],
      json['email'],
      json['role'],
      cmp,
    );
  }
}
