import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessfull extends LoginState {
  final String? role;
  final String? id;
  final String? token;

  const LoginSuccessfull(this.role, this.id, this.token);
}

class LoginFailure extends LoginState {
  final String exception;

  const LoginFailure(this.exception);
}
