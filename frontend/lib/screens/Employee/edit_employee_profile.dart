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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
            child: Card(
              elevation: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                width: 350,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                      child: Column(
                        children: [
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontSize: 33.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _fieldOfStudyController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person_off),
                                    hintText: 'What is your profession?',
                                    labelText: 'Field of study *',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Field of study cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _educationLevelController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.school_sharp),
                                    hintText:
                                        'What are your current academics?',
                                    labelText: 'Education Level *',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Education level cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _yearsOfExperienceController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.work_sharp),
                                    hintText: 'How much have you learnt?',
                                    labelText: 'Years of experience  *',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Years of experience cannot be empty";
                                    }
                                    
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _locationController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.location_city),
                                    hintText: 'Where do you live?',
                                    labelText: 'Location *',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Location cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: _bioController,
                                  autovalidateMode: AutovalidateMode.always,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.abc_sharp),
                                    hintText: 'Tell us about your self',
                                    labelText: 'Bio *',
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Bio cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<EditEmployeeBloc, EditEmployeeState>(
                              builder: ((context, state) {
                            return state is EditProfileFailed
                                ? Text(
                                    editResult,
                                    style: const TextStyle(color: Colors.red),
                                  )
                                : Text(editResult);
                          }))
                        ],
                      ),
                    ),
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
                                      width: 120,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15,),

                                      // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      child: const Center(
                                        child: Text(
                                          "Save",
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
      ),
    );
  }
}
