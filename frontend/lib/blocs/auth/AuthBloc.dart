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
        print(event.role);
        await storage.saveIdAndToken(event.role!, event.id!, event.token!);
        emit(Authenticated(event.role!, event.id!));
      },
    );
    on<LogOut>(
      (event, emit) async {
        emit(AuthLoggingOut());
        await storage.deleteAll();
        emit(AuthLogout());
      },
    );
  }
}
