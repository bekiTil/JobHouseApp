import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/screens/Company/Components/company_drawer.dart';
import 'package:frontend/screens/Company/Components/drawer.dart';
import 'package:frontend/screens/post/post.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';
import 'Components/bottomNavigationBar.dart';
import 'package:frontend/screens/Employee/Employee_/post_card/post_card.dart';

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
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 20),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadowColor: Colors.blue,
                                  elevation: 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Category: ${posts[index].category}'),
                                            const SizedBox(height: 10),
                                            Text(
                                                'Number: ${posts[index].number}'),
                                            const SizedBox(height: 10),
                                            Text(
                                                'description: ${posts[index].description}'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content: Stack(
                                                                clipBehavior:
                                                                    Clip.none,
                                                                children: <
                                                                    Widget>[
                                                                  Positioned(
                                                                    right:
                                                                        -40.0,
                                                                    top: -40.0,
                                                                    child:
                                                                        InkResponse(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          const CircleAvatar(
                                                                        child: Icon(
                                                                            Icons.close),
                                                                        backgroundColor:
                                                                            Colors.red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const PostScreen()
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  BlocConsumer<PostBloc,
                                                      PostState>(
                                                    listener:
                                                        ((context, state) {
                                                      if (state
                                                          is PostOperationFailed) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(state
                                                                    .exception)));
                                                      }
                                                      if (state
                                                          is PostOperationSuccess) {
                                                        BlocProvider.of<
                                                                    CompanyBloc>(
                                                                context)
                                                            .add(
                                                                CompanyHomeVisited());
                                                      }
                                                    }),
                                                    builder: ((context, state) {
                                                      return state
                                                                  is PostOperationLoading &&
                                                              index ==
                                                                  pressedPost
                                                          ? const CircularProgressIndicator()
                                                          : TextButton(
                                                              onPressed: () {
                                                                pressedPost =
                                                                    index;
                                                                BlocProvider.of<
                                                                            PostBloc>(
                                                                        context)
                                                                    .add(DeletePost(
                                                                        posts[index]
                                                                            .id));
                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            );
                                                    }),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Image.asset(
                                        "images/common.jpg",
                                        width: 200,
                                      )
                                    ],
                                  ),
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
