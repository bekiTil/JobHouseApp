import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyBloc>(context).add(CompanyHomeVisited());

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyBloc, CompanyState>(
      listener: (context, state) => {
        if (state is CompanyHomeLoaded && state.location == ' ')
          {context.go('/companyHome/editProfile')}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(state.fullName)),
          body: Center(
            child: state is CompanyHomeLoading
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      semanticsLabel: "Loading...",
                    ),
                  )
                : state is CompanyHomeLoadingFailed
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
