import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/secureStorage.dart';
import 'package:frontend/State_Managment/Bloc/Auth/AuthEvent.dart';
import 'package:frontend/State_Managment/Bloc/Auth/AuthState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StorageService storage;
  AuthBloc(this.storage) : super(AuthInitital()) {
    on<LoggedIn>(
      (event, emit) async {
        emit(AuthLoading());
        print(event.role);
        print(event.id);
        print(event.token);
        await storage.saveIdAndToken(event.role!, event.id!, event.token!);
        emit(Authenticated());
      },
    );
    on<LoggedOut>(
      (event, emit) async {
        emit(AuthLoading());
        await storage.deleteAll();
        emit(AuthLogout());
      },
    );
  }
}
