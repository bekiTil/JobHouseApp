import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/employee/employee_bloc.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            return state is EmployeeHomeLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  )
                : state is EmployeeHomeLoadingFailed
                    ? const Center(
                        child: Text('Err... Loading Failed'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.username,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              state.email,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              state.fullName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              state.location,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              state.bio,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.go('/employeeHome/editEmployeeProfile');
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: ((context, state) {
                                    return state is AuthLoggingOut
                                        ? const CircularProgressIndicator()
                                        : ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<AuthBloc>(context)
                                                  .add(LogOut());
                                              context.go("/login");
                                            },
                                            child: const Text('Log out'),
                                          );
                                  }),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
          },
        ),
      ],
    ));
  }
}
