import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/signup/SignUpBloc.dart';
import 'package:frontend/blocs/signup/SignUpEvent.dart';
import 'package:frontend/blocs/signup/SignUpState.dart';
import 'package:frontend/models/roles.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpBloc _signUpBloc;
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpBloc = SignUpBloc();
  }

  final _formKeyBasic = GlobalKey<FormState>();

  String selectedRole = Roles.Employee;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _submit() {
      BlocProvider.of<SignUpBloc>(context).add(SignUpSubmitted(
          username: usernameController.text,
          password: passwordController.text,
          email: emailController.text,
          role: selectedRole,
          name: nameController.text));
      context.go("/");
    }

    return BlocConsumer<SignUpBloc, SignUpState>(
        bloc: _signUpBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: Form(
                  key: _formKeyBasic,
                  child: Column(children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    Row(children: [
                      ElevatedButton(
                          onPressed: () => {
                                setState(() {
                                  selectedRole = Roles.Employee;
                                })
                              },
                          child: Text("Employee")),
                      ElevatedButton(
                          onPressed: () => {
                                setState(() {
                                  selectedRole = Roles.Company;
                                })
                              },
                          child: Text("Company")),
                    ]),
                    ElevatedButton(onPressed: _submit, child: Text("Signup"))
                  ])));
        });
  }
}
