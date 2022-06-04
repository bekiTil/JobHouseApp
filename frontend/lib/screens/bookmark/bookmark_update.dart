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
  @override
  Widget build(BuildContext context) {
    TextEditingController memoController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Update you bookmark'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    color: Colors.black12,
                    width: .9,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BookmarkHeader(bookmark: bookmark),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    Text(
                      widget.bookmark.post.description,
                      style: const TextStyle(fontSize: 15.6),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.bookmark.post.image != null &&
                        widget.bookmark.post.image!.isNotEmpty)
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: FittedBox(
                          child: Image(
                            image: NetworkImage(widget.bookmark.post.image!),
                          ),
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilterChip(
                          label: Text(
                              "Category: ${widget.bookmark.post.category}"),
                          onSelected: (bool value) {},
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        FilterChip(
                          label: Text(
                              "Candidates Needed: ${widget.bookmark.post.number}"),
                          onSelected: (bool value) {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              // _inputField('Memo', memoController),
         
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    margin: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: TextFormField(controller: memoController, ),
                  )
                ],
              ),
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
                  context.go('/employeeHome');
                },
                child: const Text('update'),
              )
            ],
          ),
        ));
  }
}

