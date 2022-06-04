// import 'dart:js';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/login/LoginBloc.dart';
import 'package:frontend/blocs/login/LoginState.dart';
import 'package:frontend/models/bookmark.dart';
import 'package:frontend/repository/secureStorage.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
import 'package:frontend/screens/Company/companyHome.dart';
import 'package:frontend/screens/Company/edit_company_profile.dart';
import 'package:frontend/screens/bookmark/bookmark_list.dart';
import 'package:frontend/screens/post/post.dart';
import 'package:frontend/screens/Employee/edit_employee_profile.dart';
import 'package:frontend/screens/Employee/employeeHome.dart';
import 'package:frontend/screens/auth/choose_role.dart';
import 'package:frontend/screens/auth/company_registration.dart';
import 'package:frontend/screens/auth/employee_registration.dart';
import 'package:go_router/go_router.dart';
import '../models/post.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/authentication_page.dart';

class AllRoutes {
  static const String loginPage = '/login';
  static const String registerPage = '/signup';
  final signup = SignUpBloc();

  final authBloc;
  // final loginBloc = LoginBloc(AuthBloc(StorageService()));

  AllRoutes({this.authBloc});

  late final router = GoRouter(
      urlPathStrategy: UrlPathStrategy.path,
      routes: [
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
              ),
              GoRoute(
                path: "post",
                builder: (BuildContext context, GoRouterState state) =>
                    const PostScreen(),
              ),
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
        GoRoute(
            name: 'bookmarkDashboard',
            path: '/bookmarkList',
            pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const BookmarkList(),
                ),
            routes: [
              // GoRoute(
              //     name: 'updateBookmark',
              //     path: 'updateBookmark',
              //     pageBuilder: (context, state) => MaterialPage(
              //           key: state.pageKey,
              //           child: UpdateBookmark(
              //             bookmark: state.extra! as Bookmark,
              //           ),
              //         )),
              // GoRoute(
              //     name: 'addBookmark',
              //     path: 'addBookmark',
              //     pageBuilder: (context, state) => MaterialPage(
              //           key: state.pageKey,
              //           child: AddBookmark(
              //             post: state.extra! as Post,
              //           ),
              //         )),
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
      redirect: (state) {
        print(authBloc.state);

        final isLoggedIn = authBloc.state is Authenticated;
        final isLoggingIn = state.location == '/login';

        print('----------');
        print(isLoggedIn);
        print(isLoggingIn);
        print('---------');

        if (!isLoggedIn && !isLoggingIn) return "/login";

        if (isLoggedIn && isLoggingIn) return '/';

        return null;
      },
      refreshListenable: GoRouterRefreshStream(authBloc.stream));
}
