import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/repository/secureStorage.dart';
import 'package:go_router/go_router.dart';

void updatePopup(BuildContext context, bookmark) async {
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
              labelText: 'Update Memo *',
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
              Bookmark newBookmark = Bookmark(
                post: bookmark.post,
                memo: memoController.value.text,
                user_id: bookmark.user_id,
                post_id: bookmark.post_id,
                id: bookmark.id,
                // createdAt: DateTime.now(),
              );

              context
                  .read<BookmarkBloc>()
                  .add(BookmarkUpdate(bookmark: newBookmark));

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
