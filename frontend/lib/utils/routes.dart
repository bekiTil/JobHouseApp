import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import '../screens/post/editPost .dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
import 'package:frontend/models/models.dart';
// import 'package:frontend/screens/Company/companyHome.dart';
import 'package:frontend/screens/Company/edit_company_profile.dart';
import 'package:frontend/screens/bookmark/bookmark_list.dart';
import 'package:frontend/screens/post/post.dart';
import 'package:frontend/screens/Employee/edit_employee_profile.dart';
import 'package:frontend/screens/Employee/employeeHome.dart';
import 'package:frontend/screens/auth/choose_role.dart';
import 'package:frontend/screens/auth/company_registration.dart';
import 'package:frontend/screens/auth/employee_registration.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/authentication_page.dart';
import 'package:frontend/screens/Company/company_home.dart';

class AllRoutes {
  static const String loginPage = '/login';
  static const String registerPage = '/signup';
  final signup = SignUpBloc();

  final authBloc;

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
                  child: const CompanyHomePage(),
                ),
            routes: [
              GoRoute(
                name: 'editProfile',
                path: 'editProfile',
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: EditCompanyProfile(
                    user: state.extra,
                  ),
                ),
              ),
              GoRoute(
                path: "post",
                builder: (BuildContext context, GoRouterState state) =>
                    const PostScreen(),
              ),
              GoRoute(
                  name: 'editPost',
                  path: 'editPost',
                  pageBuilder: (context, state) => MaterialPage(
                        key: state.pageKey,
                        child: EditPostScreen(
                          post: state.extra,
                        ),
                      ))
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
            routes: []),
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
        final isLoggedIn = authBloc.state is Authenticated;
        final isLoggingIn = state.location == '/login';

        final registerRoute = [
          "/chooseRole",
          "/employeeRegistration",
          "/companyRegistration"
        ];
        final inRegister = registerRoute.contains(state.location);

        if (!isLoggedIn && !isLoggingIn && !inRegister) return "/login";

        if (isLoggedIn && isLoggingIn) {
          return authBloc.state == Roles.Company
              ? '/companyHome'
              : '/employeeHome';
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream(authBloc.stream));
}
