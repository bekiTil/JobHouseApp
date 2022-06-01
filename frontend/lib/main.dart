import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/company/EditCompany/editcompany_bloc.dart';
import 'package:frontend/blocs/employee/editEmployee/editEmployee_bloc.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:frontend/repository/secureStorage.dart';
import 'package:frontend/repository/user_repository.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/login/LoginBloc.dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
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
  final storage = StorageService();
  final router = AllRoutes().router;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => UserRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: ((context) => AuthBloc(storage)),
            ),
            BlocProvider(
              create: ((context) =>
                  LoginBloc(BlocProvider.of<AuthBloc>(context))),
            ),
            BlocProvider(
              create: (context) => SignUpBloc(),
            ),
            BlocProvider(
              create: ((context) => CompanyBloc()),
            ),
            BlocProvider(create: ((context) => EditCompanyBloc())),
            BlocProvider(
              create: ((context) => EmployeeBloc()),
            ),
            BlocProvider(
              create: ((context) => EditEmployeeBloc()),
            )
          ],
          child: MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate),
        ));
  }
}
