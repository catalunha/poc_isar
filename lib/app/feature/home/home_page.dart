import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_isar/app/feature/user/controller/providers.dart';
import 'package:poc_isar/app/feature/utils/app_constants.dart';
import 'package:poc_isar/app/model/user_model.dart';

import '../user/user_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final formKey = GlobalKey<FormState>();
  final idTEC = TextEditingController();
  final nameTEC = TextEditingController();
  final ageTEC = TextEditingController();

  @override
  void dispose() {
    idTEC.dispose();
    nameTEC.dispose();
    ageTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final crudUser = ref.watch(cRUDUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('JRS, Isar, Riverpod'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Get data in API'),
                ),
                const SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Delete All'),
                ),
              ],
            ),
            Wrap(
              children: [
                SizedBox(
                  width: 60,
                  child: TextFormField(
                    controller: idTEC,
                    decoration: const InputDecoration(
                      label: Text('Id'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    controller: nameTEC,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatorio';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    controller: ageTEC,
                    decoration: const InputDecoration(
                      label: Text('Age'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        log('Erro no formulario.');
                      case true:
                        ref.read(cRUDUserProvider.notifier).createUser(
                              name: nameTEC.text,
                              age: int.tryParse(
                                ageTEC.text,
                              ),
                            );
                    }
                  },
                ),
                IconButton(
                    onPressed: () {
                      if (idTEC.text.isNotEmpty) {
                        ref.read(cRUDUserProvider.notifier).getById(
                              id: int.tryParse(idTEC.text),
                            );
                      }
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case false || null:
                          log('Erro no formulario.');
                        case true:
                          ref.read(cRUDUserProvider.notifier).updateUser(
                                id: int.parse(idTEC.text),
                                name: nameTEC.text,
                                age: int.tryParse(
                                  ageTEC.text,
                                ),
                              );
                      }
                    },
                    icon: const Icon(Icons.update)),
                IconButton(
                    onPressed: () {
                      if (idTEC.text.isNotEmpty) {
                        ref.read(cRUDUserProvider.notifier).delete(
                              id: int.tryParse(idTEC.text),
                            );
                      }
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
            crudUser.when(
              data: (data) {
                final UserModel? edited =
                    ref.read(cRUDUserProvider.notifier).edited();
                return Flexible(
                  child: Column(
                    children: [
                      Offstage(
                        offstage: edited == null,
                        child: Text(
                            'Item edited: ${edited?.id ?? "..."}, ${edited?.name ?? "..."}'),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).height * 0.7,
                        height: 30,
                        color: AppConstantColors.greyLight,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('List with ${data.length} Users'),
                            ElevatedButton.icon(
                                onPressed: () {
                                  ref
                                      .read(cRUDUserProvider.notifier)
                                      .sort('id');
                                },
                                icon: const Icon(Icons.sort),
                                label: const Text('id')),
                            ElevatedButton.icon(
                                onPressed: () {
                                  ref
                                      .read(cRUDUserProvider.notifier)
                                      .sort('Name');
                                },
                                icon: const Icon(Icons.sort),
                                label: const Text('Name')),
                            ElevatedButton.icon(
                                onPressed: () {
                                  ref
                                      .read(cRUDUserProvider.notifier)
                                      .sort('Age');
                                },
                                icon: const Icon(Icons.sort),
                                label: const Text('Age')),
                          ],
                        )),
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var item in data) ...[
                                UserView(
                                  model: item,
                                  getData: (value) {
                                    idTEC.text = value.id!.toString();
                                    nameTEC.text = value.name;
                                    ageTEC.text = value.age.toString();
                                  },
                                )
                              ]
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              error: (error, stackTrace) {
                return const Center(
                  child:
                      Text('Oops. Aconteceu algum erro na listagem dos itens'),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
