import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/repository/secure_storage.dart';
import 'package:go_router/go_router.dart';

void popBookmark(BuildContext context, Post post, id) async {
  final _formKey = GlobalKey<FormState>();
  TextEditingController memoController = TextEditingController();
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Bookmark'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: memoController,
            decoration: const InputDecoration(
              labelText: 'Memo *',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Memo cannot be empty';
              }

              return null;
            },
          ),
        ),
        elevation: 25.0,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
              Bookmark bookmark = Bookmark(
                  post: post,
                  memo: memoController.value.text,
                  post_id: post.id,
                  user_id: id
                  // createdAt: DateTime.now(),
                  );
              context
                  .read<BookmarkBloc>()
                  .add(BookmarkCreate(bookmark: bookmark));

              Navigator.of(context).pop();
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
