import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/secureStorage.dart';
import 'package:go_router/go_router.dart';

class UpdateBookmark extends StatefulWidget {
  final Bookmark bookmark;
  const UpdateBookmark({Key? key, required this.bookmark}) : super(key: key);

  @override
  State<UpdateBookmark> createState() => _UpdateBookmarkState();
}

class _UpdateBookmarkState extends State<UpdateBookmark> {
  // late final String? id;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   StorageService storage = StorageService();
  //   getInfo() async {
  //     id = await storage.getId();
  //   }

  //   super.initState();
  //   getInfo();

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
                    post: widget.bookmark.post,
                    memo: memoController.value.text,
                    user_id: widget.bookmark.user_id,
                    post_id: widget.bookmark.post_id,
                    id: widget.bookmark.id,
                    // createdAt: DateTime.now(),
                  );

                  context
                      .read<BookmarkBloc>()
                      .add(BookmarkUpdate(bookmark: bookmark));
                  context.go('/bookmarkList');
                },
                child: const Text('update'),
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
