import 'package:equatable/equatable.dart';

import '../../../Models/user.dart';

abstract class AuthEvent {}

class LoggedIn extends AuthEvent {
  final User? user;
  final String? token;

  LoggedIn({this.user, this.token});
}

class LoggedOut extends AuthEvent {}
