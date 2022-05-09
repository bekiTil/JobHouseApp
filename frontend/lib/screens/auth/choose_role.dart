import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/company_registration.dart';
import 'package:frontend/screens/auth/employee_registration.dart';

class ChooseRole extends StatefulWidget {
  ChooseRole({Key? key}) : super(key: key);

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  String title = "Employee";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
      ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmployeeRegistration(),
                          ),
                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompanyRegistration(),
                          ),
                        );
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
