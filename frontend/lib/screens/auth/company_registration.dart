import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
import 'package:frontend/blocs/signup/SignUpEvent.dart';
import 'package:frontend/blocs/signup/SignUpState.dart';
import 'package:frontend/models/roles.dart';
import 'package:go_router/go_router.dart';

class CompanyRegistration extends StatefulWidget {
  const CompanyRegistration({Key? key}) : super(key: key);

  @override
  State<CompanyRegistration> createState() => _CompanyRegistrationState();
}

class _CompanyRegistrationState extends State<CompanyRegistration> {
  String signupResult = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('JobHouse'),
      ),
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              width: 350,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30),
                    child: Column(
                      children: [
                        const Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 33.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        BlocListener<SignUpBloc, SignUpState>(
                          listener: ((context, state) {
                            if (state is SignUpFailure) {
                              signupResult = state.exception;
                            } else if (state is SignUpSuccess) {
                              context.go('/login');
                            }
                          }),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _companyNameController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.add_business),
                                    hintText: 'What do people call you?',
                                    labelText: 'Company Name *',
                                  ),
                                  validator: (String? value) {
                                    return value!.isEmpty
                                        ? 'Please enter your name!'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _usernameController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.abc_outlined),
                                    hintText: 'Enter your username',
                                    labelText: 'Username *',
                                  ),
                                  validator: (String? value) {
                                    return value!.length < 3
                                        ? 'Username must be at least 3 characters long!'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.email),
                                    hintText: 'Your personal email?',
                                    labelText: 'Email *',
                                  ),
                                  validator: (String? value) {
                                    bool validEmail = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value!);
                                    return !validEmail
                                        ? 'Please enter valid Email!'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.security),
                                    hintText: 'The one you only know',
                                    labelText: 'Password *',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (String? value) {
                                    return value!.isEmpty
                                        ? 'Please enter password'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  obscureText: !_passwordVisible,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.password),
                                    hintText: 'The one you only know',
                                    labelText: 'Confirm Password *',
                                  ),
                                  validator: (String? value) {
                                    return value != _passwordController.text
                                        ? 'Passwords Should match'
                                        : null;
                                  },
                                ),
                                BlocBuilder<SignUpBloc, SignUpState>(
                                    builder: ((context, state) {
                                  return state is SignUpFailure
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: Text(
                                            signupResult,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        )
                                      : Text(signupResult);
                                }))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: ((context, state) {
                      return state is SignUpLoading
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
                                    "Sign up",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpSubmitted(
                                          username: _usernameController.text,
                                          email: _emailController.text,
                                          name: _companyNameController.text,
                                          password: _passwordController.text,
                                          role: Roles.Company));
                                }
                              },
                            );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?   ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: const Text(
                            'Sign in',
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
  }
}
