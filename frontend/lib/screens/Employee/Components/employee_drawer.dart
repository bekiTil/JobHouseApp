import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/utils/constants.dart';

class EmployeeDrawer extends StatelessWidget {
  const EmployeeDrawer({Key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeDeletionSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LogOut());
          context.go("/login");
        }
      },
      builder: (context, state) {
        if (state is EmployeeHomeLoading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          );
        }

        return BlocConsumer<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is EmployeeDeletionSuccess) {
              BlocProvider.of<AuthBloc>(context).add(LogOut());
              context.go("/login");
            }
          },
          builder: (context, state) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      state.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      "@${state.username}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    currentAccountPicture: const CircleAvatar(
                      maxRadius: 35,
                      minRadius: 25,
                      backgroundImage: NetworkImage(
                          "http://10.0.2.2:3000/images/default_profile.png"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        title: const Text('Edit Profile'),
                        leading: const Icon(Icons.person),
                        onTap: () {
                          context.go('/employeeHome/editEmployeeProfile');
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        title: const Text('Delete Profile'),
                        leading: const Icon(Icons.delete),
                        onTap: () {
                          BlocProvider.of<EmployeeBloc>(context)
                              .add(DeleteEmployee(state.username));
                        },
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: ((context, state) {
                          if (state is AuthLoggingOut) {
                            return const CircularProgressIndicator();
                          }

                          return ListTile(
                            title: const Text('Logout'),
                            leading: const Icon(Icons.logout),
                            onTap: () {
                              BlocProvider.of<AuthBloc>(context).add(LogOut());
                              context.go("/login");
                            },
                          );
                        }),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
