import 'dart:js';
import 'package:frontend/repository/secureStorage.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/login/LoginBloc.dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
import 'package:frontend/screens/Company/home.dart';
import 'package:frontend/screens/Employee/home.dart';
import 'package:frontend/screens/auth/register.dart';
import '../screens/Company/home.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/authentication_page.dart';

class AllRoutes {
  static const String loginPage = '/login';
  static const String registerPage = '/signup';
  final signup = SignUpBloc();
  final authBloc = AuthBloc(StorageService());

  late final router = GoRouter(
      initialLocation: '/post',
      routes: [
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
          builder: (BuildContext context, GoRouterState state) => New(),
        ),
        GoRoute(
          path: "/post",
          builder: (BuildContext context, GoRouterState state) => const Post(),
        ),
      ],
      refreshListenable: GoRouterRefreshStream(signup.stream));
}
