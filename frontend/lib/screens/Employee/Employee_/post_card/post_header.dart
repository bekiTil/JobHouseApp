import 'package:flutter/material.dart';
import 'package:frontend/models/post.dart';

import 'bookmark_popup.dart';

class PostHeader extends StatelessWidget {
  final Post post;
  const PostHeader({Key? key, required this.post}) : super(key: key);

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
              CircleAvatar(
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
                    post.posterName ?? "Yeabsira Driba",
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
        MouseRegion(
          cursor: SystemMouseCursors.text,
          child: IconButton(
            onPressed: () {
              popBookmark(context, post);
            },
            icon: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
