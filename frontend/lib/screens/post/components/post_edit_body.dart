import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/roles.dart';

class EditPostBody extends StatefulWidget {
  const EditPostBody({Key? key}) : super(key: key);

  @override
  State<EditPostBody> createState() => _EditPostBodyState();
}

class _EditPostBodyState extends State<EditPostBody> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _categories = [
    'TECH',
    'BUSINESS',
    'ART',
    'CONSTRUCTION',
    'EDUCATION',
    'OTHER'
  ];

  String? categorySelected;
  String selectedRole = Roles.Company;
  final TextEditingController

      /// A controller for the description text field.
      _descriptionController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Post a new Job",
            style: TextStyle(
              fontSize: 33.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          DropdownButton<String>(
            value: categorySelected,
            isExpanded: true,
            hint: const Text('Choose Job Category'),
            items: _categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                categorySelected = value!;
              });
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _numberController,
            decoration:
                const InputDecoration(labelText: 'Number of available places'),
            validator: (String? value) {
              return double.tryParse(value!) == null
                  ? 'Please enter only numbers!'
                  : null;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a brief job description';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostOperationSuccess) {
                BlocProvider.of<CompanyBloc>(context).add(CompanyHomeVisited());
                context.go('/companyHome');
              }
            },
            builder: (context, state) {
              return state is PostOperationFailed
                  ? Column(
                      children: [
                        Text(
                          state.exception,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  : const Text('');
            },
          ),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              return state is PostOperationLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(16),
                      ),
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(15.0),
                        child: const Center(
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<PostBloc>(context).add(
                            PostCreate(
                              _descriptionController.text,
                              int.parse(_numberController.text),
                              categorySelected!,
                            ),
                          );
                        }
                      },
                    );
            },
          )
        ],
      ),
    );
  }
}
