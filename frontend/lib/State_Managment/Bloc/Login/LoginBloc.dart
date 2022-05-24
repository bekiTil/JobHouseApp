import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/user_repository.dart';
import 'package:frontend/State_Managment/Bloc/Login/LoginEvent.dart';
import 'package:frontend/State_Managment/Bloc/Login/LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository=UserRepository();
  LoginBloc():super(LoginInitial()){
    on<LoginPressed>((event, emit) => ,)
  }
})
