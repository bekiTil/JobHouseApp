import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/login/LoginBloc.dart';
import 'package:frontend/blocs/login/LoginEvent.dart';
import 'package:frontend/blocs/login/LoginState.dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
import 'package:frontend/blocs/signup/SignUpEvent.dart';
import 'package:frontend/blocs/signup/SignUpState.dart';
import 'package:frontend/repository/company_repository.dart';
import 'package:frontend/repository/repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([CompanyRepository, PostRepository])
void main() {
  group('Login Bloc', () {
    blocTest<LoginBloc, LoginState>(
      'emits nothing when no event is added',
      build: () => LoginBloc(AuthBloc(StorageService())),
      expect: () => [],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading] when LoginPressed is added',
      build: () => LoginBloc(AuthBloc(StorageService())),
      act: (loginBloc) => loginBloc
          .add((LoginPressed(username: 'username', password: 'password'))),
      expect: () => [
        LoginLoading(),
      ],
    );
  });

  group('Sign up Bloc', () {
    blocTest<SignUpBloc, SignUpState>(
      'emits nothing when no event is added',
      build: () => SignUpBloc(),
      expect: () => [],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [Signing up] when SignUpSubmitted is added',
      build: () => SignUpBloc(),
      act: (signUpBloc) => signUpBloc.add(
        (SignUpSubmitted(
            email: "ad",
            username: "fs",
            password: "as",
            name: "asdf",
            role: "coma")),
      ),
      expect: () => [
        SignUpLoading(),
      ],
    );
  });
}
