import 'package:flutter/material.dart';
import 'package:frontend/models/post.dart';

import 'post_header.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final bool isEmployee;
  const PostCard({Key? key, required this.post, this.isEmployee = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: .9,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post, isEmployee: isEmployee),
          const SizedBox(
            height: 15,
          ),
          Text(
            post.description,
            style: const TextStyle(fontSize: 15.6),
          ),
          const SizedBox(
            height: 10,
          ),
          if (post.image != null && post.image!.isNotEmpty)
            SizedBox(
              height: 200,
              width: double.infinity,
              child: FittedBox(
                child: Image(
                  image: NetworkImage(post.image!),
                ),
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              FilterChip(
                label: Text("Category: ${post.category}"),
                onSelected: (bool value) {},
              ),
              const SizedBox(
                width: 20,
              ),
              FilterChip(
                label: Text("Candidates Needed: ${post.number}"),
                onSelected: (bool value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
