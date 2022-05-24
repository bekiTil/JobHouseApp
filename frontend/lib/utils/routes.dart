import 'dart:js';
import 'package:frontend/State_Managment/Bloc/SignUp/SignUpBloc.dart';
import 'package:frontend/screens/auth/register.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/authentication_page.dart';

class AllRoutes {
  static const String loginPage = '/login';
  static const String registerPage = '/signup';
  final signup = SignUpBloc();

  late final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) => LoginPage(),
    ),
    GoRoute(
      path: "/signup",
      builder: (BuildContext context, GoRouterState state) => SignUpPage(),
    ),
  ], refreshListenable: GoRouterRefreshStream(signup.stream));
}
