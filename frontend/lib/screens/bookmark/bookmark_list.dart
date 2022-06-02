import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Bookmarks'),
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(builder: (context, state) {
        if (state is BookmarkOperationFailure) {
          return const Text('Failed operation');
        }
        if (state is BookmarkLoadSuccess) {
          final bookmarks = state.bookmarks;

          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (BuildContext context, index) {
              return _bookmarkCard(context, bookmarks[index]);
            },
          );
        } else {
          return const CircularProgressIndicator();
          // return Text('You are going to see bookmarks here.');
        }
      }),
    );
  }

  Card _bookmarkCard(BuildContext context, Bookmark bookmark) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The Post',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('${bookmark.memo}'),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.go('/bookmarkList/addUpdateBookmark');
                  },
                ),
                IconButton(
                  onPressed: () {
                    // context
                    //     .read<BookmarkBloc>()
                    //     .add(BookmarkDelete(bookmark: bookmark));
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
