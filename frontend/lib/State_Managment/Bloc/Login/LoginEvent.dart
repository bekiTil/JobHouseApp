import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginPressed extends LoginEvent {
  final String username;
  final String password;

  LoginPressed({required this.username, required this.password});
  @override
  List<Object> get props => [password, username];
}
