import 'package:flutter/material.dart';

import 'package:poc_isar/app/model/user_model.dart';

class UserView extends StatelessWidget {
  final UserModel model;
  final Function(UserModel) getData;
  const UserView({
    Key? key,
    required this.model,
    required this.getData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Id: ${model.id}'),
            Text('Name: ${model.name}'),
            Text('Age: ${model.age}'),
            IconButton(
                onPressed: () => getData(model), icon: const Icon(Icons.update))
          ],
        ),
      ),
    );
  }
}
