import 'package:flutter/material.dart';

class BodyCustom extends StatefulWidget {
  const BodyCustom({ Key? key }) : super(key: key);

  @override
  State<BodyCustom> createState() => _BodyCustomState();
}

class _BodyCustomState extends State<BodyCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
    );
  }
}