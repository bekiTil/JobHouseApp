import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/repository/secureStorage.dart';
import 'package:go_router/go_router.dart';
import 'bookmark_popup.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/screens/Company/Components/company_drawer.dart';
import 'package:frontend/screens/Company/Components/drawer.dart';
import 'package:frontend/screens/post/post.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:frontend/blocs/blocs.dart';
// import 'Components/bottomNavigationBar.dart';
import 'package:frontend/screens/Employee/post_card/post_card.dart';

class PostHeader extends StatefulWidget {
  final Post post;
  final bool isEmployee;
  const PostHeader({Key? key, required this.post, required this.isEmployee})
      : super(key: key);

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
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
    print('----------');
    print(widget.post.posterProfilePicture);
    print(widget.post.image);
    print(widget.post.posterName);
    print('----------');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 150, 159, 163),
                minRadius: 30,
                maxRadius: 31,
                backgroundImage:
                    NetworkImage(widget.post.posterProfilePicture),
              ),
              const SizedBox(
                width: 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.posterName ,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(widget.post.date), // TODO: change the date to a proper data
                ],
              ),
            ],
          ),
        ),
        widget.isEmployee
            ? MouseRegion(
                cursor: SystemMouseCursors.text,
                child: IconButton(
                  onPressed: () {
                    popBookmark(context, widget.post, id);
                  },
                  icon: const Icon(
                    Icons.bookmark_add,
                    // color: Colors.red,
                  ),
                ),
              )
            : Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.text,
                    child: IconButton(
                      onPressed: () {
                        // popBookmark(context, widget.post, id);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  BlocConsumer<PostBloc, PostState>(
                    listener: ((context, state) {
                      if (state is PostOperationFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.exception)));
                      }
                      if (state is PostOperationSuccess) {
                        BlocProvider.of<CompanyBloc>(context)
                            .add(CompanyHomeVisited());
                      }
                    }),
                    builder: ((context, state) {
                      return state is PostOperationLoading
                          ? const CircularProgressIndicator()
                          : MouseRegion(
                              cursor: SystemMouseCursors.text,
                              child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<PostBloc>(context)
                                      .add(DeletePost(widget.post.id));
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            );
                    }),
                  ),
                ],
              )
      ],
    );
  }
}
