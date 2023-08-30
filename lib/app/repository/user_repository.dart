import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:poc_isar/app/data/local/isar/isar_db.dart';

import '../data/local/isar/providers.dart';
import '../model/user_model.dart';

class UserRepository {
  final Isar isarDb;

  UserRepository({
    required this.isarDb,
  });
  Future<List<UserModel>> getall() async {
    final result = await isarDb.userModels.where().findAll();
    return result;
  }

  Future<UserModel?> getById(int id) async {
    final userModel = await isarDb.userModels.get(id);
    return userModel;
  }

  Future<int> create(UserModel model) async {
    int newItem = 0;
    await isarDb.writeTxn(() async {
      newItem = await isarDb.userModels.put(model);
    });
    return newItem;
  }

  Future<void> update(UserModel model) async {
    await isarDb.writeTxn(() async {
      await isarDb.userModels.put(model);
    });
  }

  Future<void> delete(int id) async {
    await isarDb.writeTxn(() async {
      await isarDb.userModels.delete(id);
    });
  }

  Future<List<UserModel>> sort(String field) async {
    return switch (field) {
      'Name' => isarDb.userModels.where().sortByName().findAll(),
      'Age' => isarDb.userModels.where().sortByAge().findAll(),
      _ => isarDb.userModels.where().findAll()
    };
  }
}
