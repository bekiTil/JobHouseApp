import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/screens/Employee/Employee_/post_card/post_card.dart';
import 'package:frontend/screens/bookmark/bookmark_postCard.dart';
import 'package:go_router/go_router.dart';

class BookmarkList extends StatefulWidget {
  const BookmarkList({Key? key}) : super(key: key);

  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarkBloc>(context).add(const BookmarkLoad());
  }

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
              return BookmarkCard(bookmark: bookmarks[index]);
            },
          );
        } else {
          return const CircularProgressIndicator();
          // return Text('You are going to see bookmarks here.');
        }
      }),
    );
  }

  // Card _bookmarkCard(BuildContext context, Bookmark bookmark) {
  //   return Card(
  //     margin: const EdgeInsets.all(10.0),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Card(
  //             child: Column(
  //               children: [
  //                 PostCard(post: bookmark.post),
  //                 const SizedBox(height: 20,),
  //                 Text('${bookmark.memo}'),

  //               ],
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               IconButton(
  //                 icon: const Icon(Icons.edit),
  //                 onPressed: () {
  //                   context.go('/bookmarkList/UpdateBookmark', extra: bookmark);
  //                 },
  //               ),
  //               IconButton(
  //                 onPressed: () {
  //                   context
  //                       .read<BookmarkBloc>()
  //                       .add(BookmarkDelete(bookmark: bookmark));
  //                 },
  //                 icon: const Icon(Icons.cancel),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
