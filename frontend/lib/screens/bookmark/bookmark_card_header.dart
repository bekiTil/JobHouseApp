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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            print('go to the user\'s profile page');
            //TODO: go to the user's profile;
          },
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 150, 159, 163),
                minRadius: 30,
                maxRadius: 31,
                backgroundImage:
                    NetworkImage("https://www.addiscoder.com/img/working.jpg"),
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
                  Text("Jan, 31"), // TODO: change the date to a proper data
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
