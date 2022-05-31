import 'package:bloc/bloc.dart';

import 'package:frontend/repository/repository.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/data_Providers/data_providers.dart';

import 'SignUpState.dart';
import 'SignUpEvent.dart';

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
