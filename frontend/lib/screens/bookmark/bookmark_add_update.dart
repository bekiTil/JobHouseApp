import 'package:flutter/material.dart';

class AddUpdateCourse extends StatefulWidget {
  AddUpdateCourse({Key? key}) : super(key: key);

  @override
  State<AddUpdateCourse> createState() => _AddUpdateCourseState();
}

class _AddUpdateCourseState extends State<AddUpdateCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add or update'),
      ),
      body: const Text('add and update functionality'),
    );
  }
}
