abstract class SignupEvent {}

class SignUpSubmitted extends SignupEvent {
  final String username;
  final String password;
  final String email;
  final String role;
  final String name;

  SignUpSubmitted({
    required this.username,
    required this.password,
    required this.email,
    required this.role,
    required this.name,
  });
}

class NewSignUp extends SignupEvent {}


