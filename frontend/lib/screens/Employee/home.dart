import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/State_Managment/Bloc/Auth/AuthEvent.dart';
import '../../State_Managment/Bloc/Auth/AuthBloc.dart';
import '../../State_Managment/Bloc/Auth/AuthState.dart';
import 'package:go_router/go_router.dart';

class New extends StatelessWidget {
  const New({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogout) {
            context.go("/");
          }
        },
        builder: (context, state) {
          return Container(
              child: ElevatedButton(
            child: Text('logout'),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            },
          ));
        },
      ),
    );
  }
}
