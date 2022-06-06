import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:frontend/models/models.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/roles.dart';

class EditPostBody extends StatefulWidget {
  final Post post;
  const EditPostBody({Key? key, required this.post}) : super(key: key);

  @override
  State<EditPostBody> createState() => _EditPostBodyState();
}

class _EditPostBodyState extends State<EditPostBody> {
  @override
  void initState() {
    super.initState();
    categorySelected = widget.post.category;
    _descriptionController.text = widget.post.description;
    _numberController.text = widget.post.number.toString();
  }

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
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Edit Your Post",
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
                            "Confirm",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<PostBloc>(context).add(
                            EditPost(
                              Post(
                                  id: widget.post.id,
                                  poster_id: widget.post.poster_id,
                                  number: int.parse(_numberController.text),
                                  description: _descriptionController.text,
                                  category: categorySelected!,
                                  posterName: widget.post.posterName,
                                  date: widget.post.date),
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
