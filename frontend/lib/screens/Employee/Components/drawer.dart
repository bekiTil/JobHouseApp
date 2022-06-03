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
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('drawerImage.jpg'),
                width: 100,
                height: 400,
              ),
              Text('Drawer Header'),
            ],
          ),
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
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  state.username,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  state.email,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 19,
                                ),
                                Text(
                                  state.fullName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      state.location,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.engineering_outlined,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  state.bio,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.go(
                                        '/employeeHome/editEmployeeProfile');
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
