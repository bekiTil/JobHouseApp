import 'package:flutter/material.dart';


ThemeData currentTheme = ThemeData.light();

var darkTheme = ThemeData(
    bottomAppBarTheme: const BottomAppBarTheme(
      color:  Color.fromARGB(255, 0, 26, 47),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor:  Color.fromARGB(255, 0, 21, 37),
    ),
    drawerTheme:const DrawerThemeData(
      backgroundColor:  Color.fromARGB(255, 0, 21, 37),
    ),
    scaffoldBackgroundColor: const  Color.fromARGB(255, 0, 26, 47),
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 1, 7, 13),
    // colorScheme: ThemeData.dark(),
  
  );







