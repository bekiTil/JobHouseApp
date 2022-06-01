import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/login/LoginBloc.dart';
import 'package:frontend/blocs/login/LoginEvent.dart';
import 'package:frontend/blocs/login/LoginState.dart';

import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String title = "Barter";
  String loginResult = "";
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    _submit() {
      BlocProvider.of<LoginBloc>(context).add(LoginPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is Authenticated) {
        if (state.role == Roles.Company) {
          context.go("/companyHome");
        } else if (state.role == Roles.Employee) {
          BlocProvider.of<EmployeeBloc>(context).add(EmployeeHomeVisited(state.id));
          context.go('/employeeHome');
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Center(child: Text(title)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Card(
              elevation: 20,
              margin: const EdgeInsets.only(top: 60),
              child: SizedBox(
                width: 350,
                height: 450,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30),
                      child: Column(
                        children: [
                          const Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 40.0,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocListener<LoginBloc, LoginState>(
                            listener: ((context, state) {
                              if (state is LoginFailure) {
                                loginResult = "Invalid username or password!";
                              } else if (state is LoginSuccessfull) {
                                BlocProvider.of<AuthBloc>(context).add(LoggedIn(
                                    id: state.id,
                                    role: state.role,
                                    token: state.token));
                              }
                            }),
                            child: Form(
                              key: _formKey,
                              child: Container(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _usernameController,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.email),
                                        hintText: 'Your personal Username?',
                                        labelText: 'Username *',
                                      ),
                                      onSaved: (value) {
                                        email = value!;
                                      },
                                      validator: (String? value) {
                                        return value!.isEmpty
                                            ? 'Please username Email!'
                                            : null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.security),
                                        hintText: 'The one you only you know?',
                                        labelText: 'Password *',
                                      ),
                                      onSaved: (value) {
                                        password = value!;
                                      },
                                      validator: (String? value) {
                                        return value!.isEmpty
                                            ? 'Please enter password'
                                            : null;
                                      },
                                    ),
                                    BlocBuilder<LoginBloc, LoginState>(
                                        builder: ((context, state) {
                                      return state is LoginFailure
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              child: Text(
                                                state.exception,
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                          : Text(loginResult);
                                    }))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: ((context, state) {
                        return state is LoginLoading
                            ? const CircularProgressIndicator(
                                color: Colors.brown,
                              )
                            : ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(16),
                                ),
                                child: Container(
                                  width: 200,
                                  padding: const EdgeInsets.all(15.0),
                                  child: const Center(
                                    child: Text(
                                      "Sign in",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        LoginPressed(
                                            username: _usernameController.text,
                                            password:
                                                _passwordController.text));
                                  }
                                },
                              );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          "Don't have an account?   ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              context.go('/chooseRole');
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
