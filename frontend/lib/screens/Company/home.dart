import 'package:flutter/material.dart';
import './components/postAppBar.dart';
import './components/postBody.dart';

class Post extends StatefulWidget {
  const Post({ Key? key }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: PostBody(),
    );
  }
}
