import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/secureStorage.dart';

class AddBookmark extends StatefulWidget {
  final Post post;
  const AddBookmark({Key? key, required this.post}) : super(key: key);

  @override
  State<AddBookmark> createState() => _AddBookmarkState();
}

class _AddBookmarkState extends State<AddBookmark> {
  final String memo = "bereket tilahun";
  late final String? id;

  @override
  void initState() {
    // TODO: implement initState
    StorageService storage = StorageService();
    getInfo() async {
      id = await storage.getId();
    }

    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add memo to your bookmark'),
        ),
        body: ElevatedButton(
            onPressed: (() {
              Bookmark bookmark = Bookmark(
                post: widget.post,
                memo: memo,
                user_id: id!,
                post_id: widget.post.id,
                createdAt: DateTime.now(),
              );

              print(bookmark);
              context
                  .read<BookmarkBloc>()
                  .add(BookmarkCreate(bookmark: bookmark));
            }),
            child: const Icon(Icons.add)));
  }
}
