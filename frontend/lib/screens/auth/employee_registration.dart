import 'package:flutter/material.dart';

class EmployeeRegistration extends StatefulWidget {
  const EmployeeRegistration({Key? key}) : super(key: key);

  @override
  State<EmployeeRegistration> createState() => _EmployeeRegistrationState();
}

class _EmployeeRegistrationState extends State<EmployeeRegistration> {
  String title = "Job House";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 20,
          child: SizedBox(
            width: 350,
            height: 450,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30),
                  child: Column(
                    children: [
                      const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // controller: username,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Your personal email?',
                          labelText: 'Email *',
                        ),
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        // validator: (String value) {
                        //   return value.contains('@')
                        //       ? 'Do not use the @ char.'
                        //       : null;
                        // },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // controller: username,
                        autovalidateMode: AutovalidateMode.always,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          hintText: 'The one you only you know?',
                          labelText: 'Password *',
                        ),
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        // validator: (String value) {
                        //   return value.contains('@')
                        //       ? 'Do not use the @ char.'
                        //       : null;
                        // },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {},
                //   style: ButtonStyle(
                //     elevation: MaterialStateProperty.all(16),
                //   ),
                //   child: const Padding(
                //     padding: EdgeInsets.all(15.0),
                //     child: Center(
                //       child: Text(
                //         "Sign in",
                //         style: TextStyle(
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(16),
                  ),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(15.0),
                    child: const Center(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "Don't have an account?   ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Center(
                      child: Center(
                        child: InkWell(
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () => {}),
                      ),
                    ),
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
