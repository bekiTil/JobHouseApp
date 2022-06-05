import 'package:flutter/material.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/secureStorage.dart';

class BookmarkHeader extends StatefulWidget {
  final Bookmark bookmark;
  const BookmarkHeader({Key? key, required this.bookmark}) : super(key: key);

  @override
  State<BookmarkHeader> createState() => _BookmarkHeaderState();
}

class _BookmarkHeaderState extends State<BookmarkHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 150, 159, 163),
                minRadius: 30,
                maxRadius: 31,
                backgroundImage:
                    NetworkImage(widget.bookmark.post.posterProfilePicture),
              ),
              const SizedBox(
                width: 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.bookmark.post.posterName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(widget.bookmark.post.date),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
