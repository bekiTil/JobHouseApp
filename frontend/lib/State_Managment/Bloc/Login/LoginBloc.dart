import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/user_repository.dart';
import 'package:frontend/State_Managment/Bloc/Auth/AuthBloc.dart';
import 'package:frontend/State_Managment/Bloc/Auth/AuthEvent.dart';
import 'package:frontend/State_Managment/Bloc/Login/LoginEvent.dart';
import 'package:frontend/State_Managment/Bloc/Login/LoginState.dart';
import 'package:http/http.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository = UserRepository();
  final AuthBloc authBloc;
  LoginBloc(this.authBloc) : super(LoginInitial()) {
    on<LoginPressed>((event, emit) async {
      emit(LoginInitial());
      try {
        final response = await userRepository.Login(
            username: event.username,
            password: event.password) as Map<String, dynamic>;
        print(response["user"]["role"]);
        authBloc.add(LoggedIn(
            role: response["user"]["role"],
            id: response["user"]["_id"],
            token: response["token"]));
        emit(LoginSuccessfull());
      } catch (e) {
        emit(LoginFailure());
      }
    });
  }
}
