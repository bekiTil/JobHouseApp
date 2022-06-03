import 'package:flutter/material.dart';
import 'package:frontend/models/post.dart';

void popBookmark(BuildContext context, Post post) async {
  final _formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Bookmark'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Memo *',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Memo cannot be empty';
              }
              //TODO: Send the bookmark request
              return null;
            },
          ),
        ),
        elevation: 25.0,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            icon: const Icon(Icons.bookmark_add),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
    },
  );
}
