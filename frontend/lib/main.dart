import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/blocs/company/EditCompany/editcompany_bloc.dart';
import 'package:frontend/blocs/employee/editEmployee/editEmployee_bloc.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:frontend/data_Providers/bookmark_data_providers.dart';
import 'package:frontend/repository/secureStorage.dart';
import 'package:frontend/repository/user_repository.dart';
import 'package:frontend/repository/bookmark_repository.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/login/LoginBloc.dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
import 'package:frontend/screens/auth/authentication_page.dart';
import 'package:frontend/screens/auth/choose_role.dart';
import 'package:frontend/utils/routes.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:frontend/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository userRepository = UserRepository();
  final BookmarkDataProvider bookmarkDataProvider = BookmarkDataProvider();
  final storage = StorageService();
  late final router;
  late final AuthBloc authBloc;

  @override
  void initState(){
    authBloc = AuthBloc(storage);
    router = AllRoutes(authBloc: authBloc).router;
  }
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider(
            create: (context) => BookmarkRepository(
              dataRepository: bookmarkDataProvider,
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: ((context) => authBloc),
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
            ),
            BlocProvider(create: ((context) => PostBloc())),
            BlocProvider(
                create: (context) => BookmarkBloc(
                      bookmarkRepository: context.read<BookmarkRepository>(),
                    )),
          ],
          child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate),
        ));
  }
}
