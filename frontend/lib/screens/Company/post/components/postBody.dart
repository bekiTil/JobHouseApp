import 'package:flutter/material.dart';
import '../../../../models/roles.dart';

class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  final _formKeyBasic = GlobalKey<FormState>();
  final List<String> _categories = ['lsdjkf', ' ldsfj', ' ksjd'];

  late String categorySelected;
  String selectedRole = Roles.Company;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyBasic,
      child: Column(
        children: [
          const Text("POST", style: TextStyle(fontSize: 18.0)),
          const SizedBox(
            height: 20.0,
          ),
          DropdownButton<String>(
            items: <String>['A', 'B', 'C', 'D'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),
          TextFormField(
            controller: descriptionController,
            decoration:
                const InputDecoration(labelText: 'Number of available places'),
          ),
          TextFormField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: 'description'),
          ),
          ElevatedButton(
              onPressed: () => {setState(() {})}, child: const Text("Post")),
        ],
      ),
    );
  }
}
