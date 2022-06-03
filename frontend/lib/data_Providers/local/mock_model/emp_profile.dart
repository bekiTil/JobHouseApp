import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";

import '../../../models/Employee.dart';
import '../../../models/employee_profile.dart';

class MockEmpProfile extends Equatable {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? role;
  final String? fullName;
  final String? fieldOfStudy;
  final String? educationLevel;
  final int? yearsOfExperience;
  final String? location;
  final String? bio;

  MockEmpProfile({
    
  this.id,
  required this.username,
  required this.email,
  required this.password,
  required this.role,
  required this.fullName,
  this.fieldOfStudy, 
  this.educationLevel,
  this.yearsOfExperience, 
  this.location, 
  this.bio
});

  @override
  List<Object?> get props => []; 
  factory MockEmpProfile.fromJson(Map<String, dynamic> json){
    return MockEmpProfile(
      id: json["_id"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      fullName: json["name"],
      fieldOfStudy: json["fieldOfStudy"],
      educationLevel: json["educationLevel"],
      yearsOfExperience: json["yearsOfExperience"],
      location:json["location"],
      bio:json["bio"],
    
    );
  }

  factory MockEmpProfile.fromApi (Map<String, dynamic> json){
    return MockEmpProfile(
      id: json["_id"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      fullName: json["name"],
      fieldOfStudy:json["profile"][0]["fieldOfStudy"],
      educationLevel: json["profile"][0]["educationLevel"],
      yearsOfExperience: json["profile"][0]["yearsOfExperience"],
      location:json["profile"][0]["location"],
      bio:json["profile"][0]["bio"],
    
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "username":username,
        "email": email,
        "password":password ,
        "role": role,
        "fulName": fullName,
        "fieldOfStudy":fieldOfStudy,
        "educationLevel":educationLevel,
        "yearsOfExperience":yearsOfExperience,
        "location":location,
        "bio":bio

      };

  

  
}