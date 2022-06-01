import 'package:flutter/material.dart';
import 'components/postBody.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Post A Job")),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            PostBody(),
          ],
        ),
      ),
    );
  }
}
