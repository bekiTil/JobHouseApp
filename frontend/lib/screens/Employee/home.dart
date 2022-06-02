import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
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
            child: const Text('logout'),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogOut());
            },
          ));
        },
      ),
    );
  }
}


