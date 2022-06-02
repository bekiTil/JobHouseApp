import 'package:flutter/material.dart';
import 'package:frontend/models/models.dart';
class AddBookmark extends StatelessWidget {
  final Post post;
  const AddBookmark({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Add memo to your bookmark'),
      ),
      body: Text('post category: ${post.category} .....'),
    );
  }
}