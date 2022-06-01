import 'dart:js';
import 'package:frontend/repository/secureStorage.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/login/LoginBloc.dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
import 'package:frontend/screens/Company/companyHome.dart';
import 'package:frontend/screens/Company/edit_company_profile.dart';
import 'package:frontend/screens/Company/post.dart';
import 'package:frontend/screens/Employee/edit_employee_profile.dart';
import 'package:frontend/screens/Employee/employeeHome.dart';
import 'package:frontend/screens/Employee/home.dart';
import 'package:frontend/screens/auth/choose_role.dart';
import 'package:frontend/screens/auth/company_registration.dart';
import 'package:frontend/screens/auth/employee_registration.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/authentication_page.dart';

class AllRoutes {
  static const String loginPage = '/login';
  static const String registerPage = '/signup';
  final signup = SignUpBloc();
  final authBloc = AuthBloc(StorageService());

  late final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) => LoginPage(),
    ),
    GoRoute(
      name: 'Login',
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: LoginPage(),
      ),
    ),
    GoRoute(
      name: 'Choose',
      path: '/chooseRole',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: ChooseRole(),
      ),
    ),
    GoRoute(
        name: 'companyRegistration',
        path: '/companyRegistration',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CompanyRegistration(),
        ),
      ),
      GoRoute(
        name: 'employeeRegistration',
        path: '/employeeRegistration',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const EmployeeRegistration(),
        ),
      ),
      GoRoute(
          name: 'companyHome',
          path: '/companyHome',
          pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const HomePage(),
              ),
          routes: [
            GoRoute(
              name: 'editProfile',
              path: 'editProfile',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const EditCompanyProfile(),
              ),
            )
          ]),
      GoRoute(
          name: 'employeeHome',
          path: '/employeeHome',
          pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const EmployeeHomePage(),
              ),
          routes: [
            GoRoute(
              name: 'editEmployeeProfile',
              path: 'editEmployeeProfile',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: const EditEmployeeProfile(),
              ),
            )
          ]),
    
    
  ],
  errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Error Occured'),
        ),
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
     refreshListenable: GoRouterRefreshStream(signup.stream));
}
