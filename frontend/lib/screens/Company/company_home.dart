import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/screens/Company/Components/company_drawer.dart';
import 'package:frontend/screens/Company/Components/drawer.dart';
import 'package:frontend/screens/post/post.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:frontend/blocs/blocs.dart';
import 'Components/bottomNavigationBar.dart';
import 'package:frontend/screens/Employee/post_card/post_card.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({Key? key}) : super(key: key);

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyBloc>(context).add(CompanyHomeVisited());
  }

  final _formKey = GlobalKey<FormState>();

  int pressedPost = 0;
  late List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyBloc, CompanyState>(
      listener: (context, state) => {
        if (state is CompanyHomeLoaded && state.location == ' ')
          {context.go('/companyHome/editProfile')},
        posts = state.posts
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("JobHouse"),
          ),
          drawer: const CompanyDrawer(),
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
                          child: Text('Error... Loading Failed'),
                        )
                      : ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) => PostCard(
                            post: state.posts[index],
                            isEmployee: false,
                          ),
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
