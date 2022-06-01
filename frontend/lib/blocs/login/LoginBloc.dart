
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/repository/repository.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/login/LoginEvent.dart';
import 'package:frontend/blocs/login/LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository = UserRepository();
  final AuthBloc authBloc;
  LoginBloc(this.authBloc) : super(LoginInitial()) {
    on<LoginPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await userRepository.Login(
            username: event.username, password: event.password);


        emit(LoginSuccessfull(response["user"]["role"], response["user"]["_id"],
            response["token"]));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
