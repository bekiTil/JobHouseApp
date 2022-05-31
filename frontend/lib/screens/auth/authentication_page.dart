import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:frontend/repository/secureStorage.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/login/LoginBloc.dart';
import 'package:frontend/blocs/login/LoginEvent.dart';
import 'package:frontend/blocs/login/LoginState.dart';
import 'package:frontend/screens/Company/home.dart';
import 'package:frontend/screens/Employee/home.dart';
import 'package:frontend/screens/auth/choose_role.dart';

import 'package:go_router/go_router.dart';
import 'package:bloc/bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  final Future<String?> role = StorageService().getRole();
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc(AuthBloc(StorageService()));
  }

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final _formKeyBasic = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _submit() {
      BlocProvider.of<LoginBloc>(context).add(LoginPressed(
        username: usernameController.text,
        password: passwordController.text,
      ));
      if (role == "Employee") {
        context.go("/homeEmployee");
      } else {
        context.go("/homeEmployee");
      }
      print(usernameController.text);
    }

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (role == "Employee") {
        context.go("/homeEmployee");
      } else {
        context.go("/homeEmployee");
      }
      },
      builder: (context, state) {
        return FutureBuilder<String?>(
            future: role,
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data == "employee") {
                    return New();
                  } else {
                    return News();
                  }
                } else {
                  return BlocConsumer<LoginBloc, LoginState>(
                      bloc: _loginBloc,
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Scaffold(
                          body: Center(
                            child: Card(
                              elevation: 20,
                              child: SizedBox(
                                width: 350,
                                height: 450,
                                child: Form(
                                  key: _formKeyBasic,
                                  child: Column(children: [
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
                                          TextFormField(
                                            controller: usernameController,
                                            validator: ValidationBuilder()
                                                .minLength(5)
                                                .maxLength(20)
                                                .build(),
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.person),
                                              hintText: 'Your username',
                                              labelText: 'Username',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            controller: passwordController,
                                            validator: ValidationBuilder()
                                                .minLength(8)
                                                .maxLength(20)
                                                .build(),
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.password),
                                              hintText:
                                                  'The one you only you know?',
                                              labelText: 'Password *',
                                            ),
                                            obscureText: true,
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(16),
                                            ),
                                            child: Container(
                                              width: 200,
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: const Center(
                                                child: Text(
                                                  "Sign in",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onPressed: _submit,
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 40),
                                              const Text(
                                                "Don't have an account?   ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Center(
                                                child: Center(
                                                  child: InkWell(
                                                      child: const Text(
                                                        'Sign Up',
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      onTap: () => {
                                                            context
                                                                .go('/signup')
                                                          }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
              } else {
                return Text("Error");
              }
            });
      },
    );
  }
}
