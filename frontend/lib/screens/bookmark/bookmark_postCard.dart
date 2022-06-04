import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/bookmark/bookmark_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/screens/bookmark/bookmark_postCard_header.dart';
import 'package:go_router/go_router.dart';

class BookmarkCard extends StatelessWidget {
  final Bookmark bookmark;
  const BookmarkCard({Key? key, required this.bookmark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bookmark.post.image = "https://www.addiscoder.com/img/working.jpg";

    return Container(
      margin: const EdgeInsets.all(10),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilterChip(
                label: Text("Category: ${bookmark.post.category}"),
                onSelected: (bool value) {},
              ),
              const SizedBox(
                width: 20,
              ),
              FilterChip(
                label: Text("Candidates Needed: ${bookmark.post.number}"),
                onSelected: (bool value) {},
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Icon(Icons.push_pin),
              // const SizedBox(
              //   height: 5,
              // ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 162, 167, 169),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                width: double.maxFinite,
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  '${bookmark.memo}',
                  style: const TextStyle(
                      fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.go('/bookmarkList/UpdateBookmark', extra: bookmark);
                },
              ),
              IconButton(
                onPressed: () {
                  context
                      .read<BookmarkBloc>()
                      .add(BookmarkDelete(bookmark: bookmark));
                },
                icon: const Icon(Icons.cancel),
              ),
            ],
          )
        ],
      ),
    );
  }
}
