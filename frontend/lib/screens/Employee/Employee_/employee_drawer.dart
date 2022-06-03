import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmployeeDrawer extends StatelessWidget {
  const EmployeeDrawer({key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              "Yeabsira Driba",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "@dryeab",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              maxRadius: 35,
              minRadius: 25,
              backgroundImage: NetworkImage(
                  "http://10.0.2.2:3000/images/default_profile.png"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ListTile(
                      title: const Text('Profile'),
                      leading: const Icon(Icons.person),
                      onTap: () {
                        // Navigator.pop(context);
                        context.pop();
                        //TODO: context.go('editprofile');
                      },
                    ),
                    ListTile(
                      title: const Text('Bookmark'),
                      leading: const Icon(Icons.bookmark),
                      onTap: () {
                        Navigator.pop(context);
                        //TODO: context.go('bookmarks');
                      },
                    ),
                    ListTile(
                      title: const Text('Contact Us'),
                      leading: const Icon(Icons.call),
                      onTap: () {
                        Navigator.pop(context);
                        //TODO: context.go('bookmarks');
                      },
                    ),
                    ListTile(
                      title: const Text('Invite Friends'),
                      leading: const Icon(Icons.share),
                      onTap: () {
                        Navigator.pop(context);
                        //TODO: context.go('bookmarks');
                      },
                    ),
                  ],
                ),
                ListTile(
                  title: const Text('Logout'),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    Navigator.pop(context);
                    //TODO: context.go('editprofile');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
