class SignUpState {
  final String username;
  bool get isUsernameValid => username.length >= 5 && username.length < 20;

  final String email;
  bool get isEmailValid => email.contains("@");

  final String password;
  bool get isPasswordValid => password.length >= 8;

  final String role;

  final String name;
  bool get isNameValid => name.length >= 5 && name.length < 30;

  SignUpState({
    this.username = "",
    this.email = "",
    this.password = "",
    this.role = "",
    this.name = "",
  });

  SignUpState copyWith({
    String? username,
    String? email,
    String? password,
    String? role,
    String? name,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
      name: name ?? this.name,
    );
  }
}
