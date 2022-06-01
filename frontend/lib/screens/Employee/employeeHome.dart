import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  State<EmployeeHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<EmployeeHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) => {
        if (state is EmployeeHomeLoaded && state.location == ' ')
          {context.go('/employeeHome/editEmployeeProfile')}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(state.fullName)),
          body: Center(
            child: state is EmployeeHomeLoading
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      semanticsLabel: "Loading...",
                    ),
                  )
                : state is EmployeeHomeLoadingFailed
                    ? const Center(
                        child: Text('Err... Loading Failed'),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(state.username),
                          Text(state.email),
                          Text(state.fullName),
                          Text(state.location),
                          Text(state.bio),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: ((context, state) {
                              return state is AuthLoggingOut
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<AuthBloc>(context)
                                            .add(LoggedOut());
                                        context.go('/login');
                                      },
                                      child: const Text('Log out'),
                                    );
                            }),
                          )
                        ],
                      ),
          ),
        );
      },
    );
  }
}
