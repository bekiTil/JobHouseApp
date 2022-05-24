import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/user_repository.dart';
import 'package:frontend/State_Managment/Bloc/SignUp/SignUpBloc.dart';
import 'package:frontend/screens/auth/authentication_page.dart';
import 'package:frontend/screens/auth/choose_role.dart';
import 'package:frontend/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository userRepository = UserRepository();
  final router = AllRoutes().router;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => UserRepository(),
        child: MultiBlocProvider(
          providers: [BlocProvider(create: (context) => SignUpBloc())],
          child: MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate),
        ));
  }
}
