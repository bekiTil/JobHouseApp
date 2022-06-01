abstract class AuthState {}

class AuthInitital extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String role;
  final String id;

  Authenticated(this.role, this.id);
}

class UnAuthenitcated extends AuthState {}

class AuthLoggingOut extends AuthState {}
class AuthLogout extends AuthState {}
