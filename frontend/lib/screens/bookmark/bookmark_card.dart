import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/screens/bookmark/bookmark_card_header.dart';
import 'package:frontend/screens/bookmark/bookmark_update_popup.dart';
import 'package:go_router/go_router.dart';

class BookmarkCard extends StatelessWidget {
  final Bookmark bookmark;
  const BookmarkCard({Key? key, required this.bookmark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bookmark.post.image = "https://www.addiscoder.com/img/working.jpg";

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookmarkHeader(bookmark: bookmark),
            const SizedBox(
              height: 15,
            ),
            Text(
              bookmark.post.description,
              style: const TextStyle(fontSize: 15.6),
            ),
            const SizedBox(
              height: 10,
            ),
            if (bookmark.post.image != null && bookmark.post.image!.isNotEmpty)
              SizedBox(
                height: 200,
                width: double.infinity,
                child: FittedBox(
                  child: Image(
                    image: NetworkImage(bookmark.post.image!),
                  ),
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: FilterChip(
                    label: Text("Category: ${bookmark.post.category}"),
                    onSelected: (bool value) {},
                  ),
                ),
            
                Expanded(
                  child: FilterChip(
                    label: Text("Candidates: ${bookmark.post.number}"),
                    onSelected: (bool value) {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const Text('Memo', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), ),
                const SizedBox(height: 5,),
                Container(

                  decoration:  BoxDecoration(
                    color: Color.fromARGB(255, 220, 224, 226),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${bookmark.memo}',
                    style:
                        const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    updatePopup(context, bookmark);
                  },
                  child: const Text('UPDATE'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<BookmarkBloc>()
                        .add(BookmarkDelete(bookmark: bookmark));
                  },
                  child: const Text('DELETE'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
