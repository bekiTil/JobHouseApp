abstract class SignupEvent {}

class UsernameChanged extends SignupEvent {
  final String? username;
  UsernameChanged({required this.username});
}

class EmailChanged extends SignupEvent {
  final String? email;
  EmailChanged({required this.email});
}

class PasswordChanged extends SignupEvent {
  final String? password;
  PasswordChanged({required this.password});
}

class RoleChanged extends SignupEvent {
  final String? role;
  RoleChanged({required this.role});
}

class NameChanged extends SignupEvent {
  final String? name;
  NameChanged({required this.name});
}

class SignUpSubmitted extends SignupEvent {}

class NewSignUp extends SignupEvent {}
