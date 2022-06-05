import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:frontend/models/bookmark.dart';
import 'package:frontend/screens/Employee/post_card/post_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: state is EmployeeHomeLoading
              ? const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    semanticsLabel: "Loading...",
                  ),
                )
              : state is EmployeeHomeLoadingFailed
                  ? const Center(
                      child: Text('Loading Failed'),
                    )
                  : ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) =>
                          PostCard(post: state.posts[index]),
                    ),
        );
      },
    );
  }
}
