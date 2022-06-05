import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:go_router/go_router.dart';
import '../../../blocs/theme/changetheme_bloc.dart';

class CompanyDrawer extends StatelessWidget {
  const CompanyDrawer({Key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state is CompanyProfileDeletionSuccessfull) {
          context.go('/login');
        }
      },
      builder: (context, state) {
        if (state is CompanyHomeLoading) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          );
        }

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  state.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "@${state.username}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: const CircleAvatar(
                  maxRadius: 35,
                  minRadius: 25,
                  backgroundImage: NetworkImage(
                      "http://10.0.2.2:3000/images/default_profile.png"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    BlocBuilder<ChangethemeBloc, ChangethemeState>(
                        builder: (context, state) {
                          return state is LightTheme
                              ? ListTile(
                                  title: const Text('Night Mode'),
                                  leading: const Icon(Icons.nightlight),
                                  onTap: () {
                                    BlocProvider.of<ChangethemeBloc>(context)
                                        .add(ChangethemeTODark());
                                  },
                                )
                              : ListTile(
                                  title: const Text('Light Mode'),
                                  leading: const Icon(Icons.sunny),
                                  onTap: () {
                                    BlocProvider.of<ChangethemeBloc>(context)
                                        .add(ChangethemeTOLight());
                                  });
                        },
                      ),
                  ListTile(
                    title: const Text('Edit Profile'),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      context.go('/companyHome/editprofile', extra: state);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: const Text('Delete Profile'),
                    leading: const Icon(Icons.delete),
                    onTap: () {
                      BlocProvider.of<CompanyBloc>(context)
                          .add(DeleteCompany(state.username));

                      BlocProvider.of<AuthBloc>(context).add(LogOut());
                      context.go('/login');
                    },
                  ),
            
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: ((context, state) {
                      if (state is AuthLoggingOut) {
                        return const CircularProgressIndicator();
                      }

                      return ListTile(
                        title: const Text('Logout'),
                        leading: const Icon(Icons.logout),
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(LogOut());
                          context.go("/login");
                        },
                      );
                    }),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
