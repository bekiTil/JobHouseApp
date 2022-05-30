import 'package:frontend/Repository/user_repository.dart';

import 'SignUpState.dart';
import 'SignUpEvent.dart';

import '../../../Models/user.dart';
import 'package:bloc/bloc.dart';
import '../../../Data_Provider/auth.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  final UserRepository userRepository = UserRepository();
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpLoading());
     final User user = User(
          username: event.username,
          email: event.email,
          password: event.password,
          role: event.role,
          name: event.name);
      try {
        await userRepository.SignUp(user: user);
      } catch (e) {
        throw (e);
      }
    });
  }
}
