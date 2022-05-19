import 'package:flutter/material.dart';
import './home_page_components/body.dart';
import './home_page_components/appBar.dart';
import './home_page_components/drawer.dart';
import './home_page_components/buttomNavigationBar.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("JobHouse")),
      body: const BodyCustom(),
      drawer: const DrawerCustom(),
      bottomNavigationBar: const BottomNavigationBarCustom(),

      
    );
  }
}