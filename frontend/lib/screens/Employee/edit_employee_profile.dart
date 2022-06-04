import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/employee/editEmployee/editEmployee_bloc.dart';
import 'package:frontend/blocs/employee/employee_bloc.dart';
import 'package:frontend/repository/repository.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class EditEmployeeProfile extends StatefulWidget {
  const EditEmployeeProfile({Key? key}) : super(key: key);

  @override
  State<EditEmployeeProfile> createState() => _EditEmployeeProfileState();
}

class _EditEmployeeProfileState extends State<EditEmployeeProfile> {
  String token = '';
  String id = '';
  getId() async {
    final storage = StorageService();
    final String? _id = await storage.getId();
    setState(() {
      id = _id!;
    });
  }

  getToken() async {
    final storage = StorageService();
    final String? _token = await storage.getToken();
    setState(() {
      token = _token!;
    });
  }

  @override
  void initState() {
    super.initState();
    getId();
    getToken();
  }

  final _formKey = GlobalKey<FormState>();
  String editResult = '';
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _educationLevelController =
      TextEditingController();
  final TextEditingController _yearsOfExperienceController =
      TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return BlocListener<EditEmployeeBloc, EditEmployeeState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          print(id);
          BlocProvider.of<EmployeeBloc>(context).add(EmployeeHomeVisited());
          context.go('/employeeHome');
        } else if (state is EditProfileFailed) {
          editResult = state.exception;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Center(
            child: Text("JobHouse"),
          ),
        ),
        key: _scaffoldKey,
        body: Center(
          child: Card(
            elevation: 20,
            child: SizedBox(
              width: 350,
              height: 550,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30),
                    child: Column(
                      children: [
                        const Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _fieldOfStudyController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person_pin_circle),
                                    hintText: 'What is your profession?',
                                    labelText: 'Field of study *',
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
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _educationLevelController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.description),
                                    hintText:
                                        'What are your current academics?',
                                    labelText: 'Education Level *',
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
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _yearsOfExperienceController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.description),
                                    hintText: 'How much have you learnt?',
                                    labelText: 'Years of experience  *',
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
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _locationController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.description),
                                    hintText: 'Where do you live?',
                                    labelText: 'location *',
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
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _bioController,
                                  autovalidateMode: AutovalidateMode.always,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.abc_outlined),
                                    hintText: 'Tell us about your self',
                                    labelText: 'bio *',
                                  ),
                                  onSaved: (value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        BlocBuilder<EditEmployeeBloc, EditEmployeeState>(
                            builder: ((context, state) {
                          return state is EditProfileFailed
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    editResult,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                )
                              : Text(editResult);
                        }))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<EditEmployeeBloc, EditEmployeeState>(
                    builder: (context, state) {
                      return state is EditingProfile
                          ? const CircularProgressIndicator()
                          : BlocBuilder<EmployeeBloc, EmployeeState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(16),
                                  ),
                                  child: Container(
                                    width: 200,
                                    padding: const EdgeInsets.all(15.0),
                                    child: const Center(
                                      child: Text(
                                        "Confirm",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      int yearsOfExperience =
                                          (_yearsOfExperienceController
                                                  .text.isNotEmpty)
                                              ? int.parse(
                                                  _yearsOfExperienceController
                                                      .text)
                                              : 0;

                                      (BlocProvider.of<EditEmployeeBloc>(
                                              context)
                                          .add(
                                        EditEmployee(
                                            _locationController.text,
                                            _bioController.text,
                                            token,
                                            id,
                                            _fieldOfStudyController.text,
                                            _educationLevelController.text,
                                            yearsOfExperience),
                                      ));
                                    }
                                  },
                                );
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
