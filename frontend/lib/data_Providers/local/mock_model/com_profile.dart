import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";

import '../../../models/Company.dart';
import '../../../models/company_profile.dart';

class MockCompProfile extends Equatable {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? role;
  final String? fullName;
  final String? location;
  final String? bio;

  MockCompProfile(
      {this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.role,
      required this.fullName,
      this.location,
      this.bio});

  @override
  List<Object?> get props => [];
  factory MockCompProfile.fromJson(Map<String, dynamic> json) {
    return MockCompProfile(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      fullName: json["name"],
      location: json["location"],
      bio: json["bio"],
    );
  }

    factory MockCompProfile.fromApi (Map<String, dynamic> json){
    return MockCompProfile(
      id: json["_id"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      fullName: json["name"],
      location:json["profile"][0]["location"],
      bio:json["profile"][0]["bio"],
    
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "role": role,
        "fullName": fullName,
        "location": location,
        "bio": bio
      };
}
