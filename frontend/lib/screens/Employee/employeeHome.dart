import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:frontend/screens/Employee/Components/bottomNavigationBar.dart';
import 'package:frontend/screens/Employee/Components/drawer.dart';
import 'package:frontend/screens/Employee/Components/homeBody.dart';
import 'package:frontend/screens/Employee/Employee_/employee_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';
import '../../screens/bookmark/bookmark_list.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  State<EmployeeHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<EmployeeHomePage> {
  int _selectedindex = 0;
  final List<Widget> screens = const [HomeBody(), BookmarkList()];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<EmployeeBloc>(context).add(EmployeeHomeVisited());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) => {
        if (state is EmployeeHomeLoaded && state.location == ' ')
          {context.go('/employeeHome/editEmployeeProfile')}
      },
      builder: (context, state) {
        return Scaffold(
          drawer: DrawerCustom(),
          appBar: AppBar(title: Text(state.fullName)),
          body: screens[_selectedindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedindex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border),
                label: 'Bookmarks',
              ),
            ],
            onTap: (value) {
              setState(() {
                _selectedindex = value;
              });
            },
          ),
        );
      },
    );
  }
}
