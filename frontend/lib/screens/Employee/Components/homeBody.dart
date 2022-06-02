import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';

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
                        child: Text('Err... Loading Failed'),
                      )
                    : ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) => GestureDetector(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 15,
                          ),
                          child: Card(
                            shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.black,
                            elevation: 90,
                            color: Colors.blueAccent,
                            child: Column(
                              children: [
                                Text(
                                    'Category: ${state.posts[index].category}'),
                                Text(
                                    'description: ${state.posts[index].description}'),
                                Text('Number: ${state.posts[index].number}'),
                                Text('date:  ')
                              ],
                            ),
                          ),
                        )),
                      ));
      },
    );
  }
}
