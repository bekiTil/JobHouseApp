import 'package:flutter/material.dart';

class BottomNavCustom extends StatefulWidget {
  const BottomNavCustom({ Key? key }) : super(key: key);

  @override
  State<BottomNavCustom> createState() => _BottomNavCustomState();
}

class _BottomNavCustomState extends State<BottomNavCustom> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _selectedindex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Requests',
            
          ),
        
        ],
      onTap: (value){
        setState(() {
          _selectedindex = value;
        });
      },
      );
  }
}