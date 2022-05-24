import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/State_Managment/Bloc/SignUp/SignUpBloc.dart';
import 'package:frontend/State_Managment/Bloc/SignUp/SignUpEvent.dart';
import 'package:frontend/State_Managment/Bloc/SignUp/SignUpState.dart';
import '../../Models/roles.dart';
import 'package:form_validator/form_validator.dart';

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
                      validator: ValidationBuilder()
                          .minLength(5)
                          .maxLength(20)
                          .build(),
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: ValidationBuilder()
                          .email()
                          .minLength(5)
                          .maxLength(35)
                          .build(),
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: ValidationBuilder()
                          .minLength(8)
                          .maxLength(20)
                          .build(),
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: ValidationBuilder()
                          .minLength(5)
                          .maxLength(35)
                          .build(),
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
