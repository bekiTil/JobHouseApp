import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseRole extends StatefulWidget {
  ChooseRole({Key? key}) : super(key: key);

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(
        child: Card(
          elevation: 20,
          child: SizedBox(
            width: 350,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Are you",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Container(
                          color: Colors.blue,
                          width: 80,
                          height: 100,
                          child: const Center(
                            child: Text(
                              "Employee",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100),
                            ),
                          )),
                      onPressed: () {
                        context.go("/employeeRegistration");
                      },
                    ),
                    const Text("OR"),
                    ElevatedButton(
                      child: Container(
                        color: Colors.blue,
                        width: 80,
                        height: 100,
                        child: const Center(
                          child: Text(
                            "Company",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.go('/companyRegistration');
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
