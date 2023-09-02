import 'package:isar/isar.dart';

import 'package:poc_isar/app/repository/user_repository.dart';

import '../model/user_model.dart';

class UserRepositoryIsar extends UserRepository {
  final Isar isarDb;

  UserRepositoryIsar({
    required this.isarDb,
  });
  @override
  Future<List<UserModel>> getall() async {
    return await isarDb.userModels.where().findAll();
  }

  @override
  Future<UserModel?> getById(int id) async {
    final userModel = await isarDb.userModels.get(id);
    return userModel;
  }

  @override
  Future<int> create(UserModel model) async {
    int newItem = 0;
    await isarDb.writeTxn(() async {
      newItem = await isarDb.userModels.put(model);
    });
    return newItem;
  }

  @override
  Future<void> update(UserModel model) async {
    await isarDb.writeTxn(() async {
      await isarDb.userModels.put(model);
    });
  }

  @override
  Future<void> delete(int id) async {
    await isarDb.writeTxn(() async {
      await isarDb.userModels.delete(id);
    });
  }

  // Future<List<UserModel>> sort(String field) async {
  //   return switch (field) {
  //     'Name' => isarDb.userModels.where().sortByName().findAll(),
  //     'Age' => isarDb.userModels.where().sortByAge().findAll(),
  //     _ => isarDb.userModels.where().findAll()
  //   };
  // }
}
