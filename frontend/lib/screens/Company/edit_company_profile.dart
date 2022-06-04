import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/company/EditCompany/editcompany_bloc.dart';
import 'package:frontend/repository/repository.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class EditCompanyProfile extends StatefulWidget {
  const EditCompanyProfile({Key? key}) : super(key: key);

  @override
  State<EditCompanyProfile> createState() => _EditCompanyProfileState();
}

class _EditCompanyProfileState extends State<EditCompanyProfile> {
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

  String title = "JobHouse";
  final _formKey = GlobalKey<FormState>();
  String editResult = '';
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return BlocListener<EditCompanyBloc, EditCompanyState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          print(id);
          BlocProvider.of<CompanyBloc>(context).add(CompanyHomeVisited());
          context.go('/companyHome');
        } else if (state is EditProfileFailed) {
          editResult = state.exception;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Center(
            child: Text(title),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                width: 350,
                height: 350,
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
                              fontSize: 33.0,
                              fontWeight: FontWeight.w500,
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
                                    controller: _locationController,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.location_city),
                                      hintText: 'Where do you live?',
                                      labelText: 'Location *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please insert your location";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _bioController,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.abc_outlined),
                                      hintText: 'Tell us about your self',
                                      labelText: 'Bio *',
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please insert bio";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocBuilder<EditCompanyBloc, EditCompanyState>(
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
                    // const SizedBox(height: 10),
                    BlocBuilder<EditCompanyBloc, EditCompanyState>(
                      builder: (context, state) {
                        return state is EditingProfile
                            ? const CircularProgressIndicator()
                            : BlocBuilder<CompanyBloc, CompanyState>(
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
                                        BlocProvider.of<EditCompanyBloc>(
                                                context)
                                            .add(
                                          EditCompany(_locationController.text,
                                              _bioController.text, token, id),
                                        );
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
