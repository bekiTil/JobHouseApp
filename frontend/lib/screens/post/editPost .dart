import 'package:flutter/material.dart';
import 'package:frontend/models/models.dart';
import 'components/post_edit_body.dart';
class EditPostScreen extends StatefulWidget {
  final post;
  const EditPostScreen({Key? key,required this.post}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Edit your post ")),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  EditPostBody(post: widget.post),
                ],
              ),
            ),
          ),
        ));
  }
}
