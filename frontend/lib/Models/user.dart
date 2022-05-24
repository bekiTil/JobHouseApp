import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";

@immutable
class User extends Equatable {
  late final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? role;
  final String? name;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.name,
  });
  @override
  List<Object?> get props => [id, username, email, password, role, name];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      username: json["username"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      name: json["name"],
    );
  }
}
