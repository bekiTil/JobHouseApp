import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/screens/Company/drawer.dart';
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
          drawer: const DrawerCustom(),
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
                      : ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) => GestureDetector(
                              child: Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Column(
                              children: [
                                Text(
                                    'Category: ${state.posts[index].category}'),
                                const SizedBox(height: 10),
                                Text(
                                    'description: ${state.posts[index].description}'),
                                const SizedBox(height: 10),
                                Text('Number: ${state.posts[index].number}'),
                              ],
                            ),
                          )),
                        )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go('/companyHome/post');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
