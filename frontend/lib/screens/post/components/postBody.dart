import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/roles.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _categories = [
    'TECH',
    'BUSINESS',
    ' ART',
    'CONSTRUCTION',
    'EDUCATION'
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
            "POST",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
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
                  ? 'Please only numbers'
                  : null;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'description'),
            validator: (String? value) {
              return value!.isEmpty
                  ? 'Please enter small job description'
                  : null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is PostCreated){
                context.go('/companyHome');
              }
            },
            builder: (context, state) {
              return state is PostCreationFailed
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
              return state is PostCreating
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
