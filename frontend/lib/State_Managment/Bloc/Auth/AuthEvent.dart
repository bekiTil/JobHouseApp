import 'package:equatable/equatable.dart';

import '../../../Models/user.dart';

abstract class AuthEvent {}

class LoggedIn extends AuthEvent {
  final String? role;
  final String? id;
  final String? token;

  LoggedIn({this.role, this.id, this.token});
}

class LoggedOut extends AuthEvent {}
