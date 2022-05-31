import 'package:flutter/material.dart';
import '../../../Models/roles.dart';
import 'package:form_validator/form_validator.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  final _formKeyBasic = GlobalKey<FormState>();
  final _categories = ['lsdjkf', ' ldsfj', ' ksjd'];


  String selectedRole = Roles.Company;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyBasic,
        child: Column(
          children: [
            DropdownButton<string>(
              items: _categories.map().toList(),
              // controller: categoryController,
              // validator: ValidationBuilder().minLength(5).maxLength(35).build(),
              // decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: numberController,
              validator: ValidationBuilder().minLength(5).maxLength(35).build(),
              decoration: const InputDecoration(labelText: 'Number of spaces available'),
            ),
            TextFormField(
              controller: descriptionController,
              validator: ValidationBuilder().minLength(5).maxLength(35).build(),
              decoration: const InputDecoration(labelText: 'description'),
            ),
            TextFormField(
              controller: categoryController,
              validator: ValidationBuilder().minLength(5).maxLength(35).build(),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
          ],
        ),
      ),
    );
  }
}
