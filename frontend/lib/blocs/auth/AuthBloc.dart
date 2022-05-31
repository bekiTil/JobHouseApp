import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/repository/secureStorage.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StorageService storage;
  AuthBloc(this.storage) : super(AuthInitital()) {
    on<LoggedIn>(
      (event, emit) async {
        emit(AuthLoading());
        pritn(event.role);
        await storage.saveIdAndToken(event.role!, event.id!, event.token!);
        print(event.token);
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
