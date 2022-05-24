import 'dart:js';
import 'package:frontend/Repository/secureStorage.dart';
import 'package:frontend/State_Managment/Bloc/Auth/AuthBloc.dart';
import 'package:frontend/State_Managment/Bloc/Auth/AuthEvent.dart';
import 'package:frontend/State_Managment/Bloc/Login/LoginBloc.dart';
import 'package:frontend/State_Managment/Bloc/SignUp/SignUpBloc.dart';
import 'package:frontend/screens/Company/home.dart';
import 'package:frontend/screens/Employee/home.dart';
import 'package:frontend/screens/auth/register.dart';

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
      path: "/signup",
      builder: (BuildContext context, GoRouterState state) => SignUpPage(),
    ),
    GoRoute(
      path: "/homeEmployee",
      builder: (BuildContext context, GoRouterState state) => New(),
    ),
    GoRoute(
      path: "/homeCompany",
      builder: (BuildContext context, GoRouterState state) => News(),
    ),
  ], refreshListenable: GoRouterRefreshStream(signup.stream));
}
