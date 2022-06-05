import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/screens/bookmark/bookmark_card.dart';

class BookmarkList extends StatefulWidget {
  const BookmarkList({Key? key}) : super(key: key);

  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarkBloc>(context).add(BookmarkLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarkBloc, BookmarkState>(
        listener: ((context, state) {
      if (state is BookmarkLoadSuccess && state.type == "delete") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bookmark Deleted')),
        );
      }
    }), builder: (context, state) {
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
      }
    });
  }
}
