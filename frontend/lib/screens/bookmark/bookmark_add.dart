// ignore_for_file: prefer_const_constructors

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
    TextEditingController memoController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add memo to your bookmark'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _inputField('Memo', memoController),
              ElevatedButton(
                onPressed: () {
                  Bookmark bookmark = Bookmark(
                    post: widget.post,
                    memo: memoController.value.text,
                    user_id: id!,
                    post_id: widget.post.id,
                    // createdAt: DateTime.now(),
                  );

                  context
                      .read<BookmarkBloc>()
                      .add(BookmarkCreate(bookmark: bookmark));
//
                },
                child: const Text('Add To Bookmark'),
              )
            ],
          ),
        ));
  }
}

Column _inputField(
  String field,
  TextEditingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 50,
        margin: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: TextFormField(controller: controller),
      )
    ],
  );
}

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Add memo to your bookmark'),
//         ),
//         body: ElevatedButton(
//             onPressed: (() {
// Bookmark bookmark = Bookmark(
//   post: widget.post,
//   memo: memo,
//   user_id: id!,
//   post_id: widget.post.id,
//   // createdAt: DateTime.now(),
// );

//               context
//                   .read<BookmarkBloc>()
//                   .add(BookmarkCreate(bookmark: bookmark));
//             }),
//             child: const Icon(Icons.add)));
//   }
