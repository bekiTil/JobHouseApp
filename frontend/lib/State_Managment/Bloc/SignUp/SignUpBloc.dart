import 'SignUpState.dart';
import 'SignUpEvent.dart';

import '../../../Models/user.dart';
import 'package:bloc/bloc.dart';
import '../../../Data_Provider/auth.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  final AuthProvider authProvider;
  SignUpBloc({required this.authProvider}) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignupEvent event) async* {
    if (event is UsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is EmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is PasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is RoleChanged) {
      yield state.copyWith(role: event.role);
    } else if (event is NameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is NewSignUp) {
      yield state.copyWith(
          username: "", email: "", password: "", role: "", name: "");
    } else if (event is SignUpSubmitted) {
      User user = User(
          username: state.username,
          email: state.email,
          password: state.password,
          role: state.role,
          name: state.name);
      try {
        authProvider.signup(user);
      } catch (e) {
        throw (e);
      }
    }
  }
}
