import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/auth/AuthBloc.dart';
import 'package:frontend/blocs/auth/AuthEvent.dart';
import 'package:frontend/blocs/auth/AuthState.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:frontend/screens/Employee/Components/bottomNavigationBar.dart';
import 'package:frontend/screens/Employee/Components/drawer.dart';
import 'package:frontend/screens/Employee/Components/homeBody.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  State<EmployeeHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<EmployeeHomePage> {
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
          drawer: const DrawerCustom(),
          appBar: AppBar(title: Text(state.fullName)),
          body: const HomeBody(),
          bottomNavigationBar: const BottomNavCustom(),
        );
      },
    );
  }
}
