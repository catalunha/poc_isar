import 'package:poc_isar/app/repository/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../model/user_model.dart';

part 'providers.g.dart';

@riverpod
class CRUDUser extends _$CRUDUser {
  @override
  Future<List<UserModel>> build() async {
    final repo = await ref.read(userRepositoryProvider.future);
    final list = await repo.getall();
    return list;
  }

  UserModel? _editedUser;
  UserModel? edited() {
    return _editedUser;
  }

  Future<UserModel?> getById({int? id}) async {
    final repo = await ref.read(userRepositoryProvider.future);
    _editedUser = await repo.getById(id ?? 0);
    ref.invalidateSelf();
    return _editedUser;
  }

  Future<void> createUser({required String name, int? age}) async {
    final userModel = UserModel(name: name, age: age);

    final repo = await ref.read(userRepositoryProvider.future);
    int? id = await repo.create(userModel);
    _editedUser = await getById(id: id);

    state = AsyncData([_editedUser!, ...state.requireValue]);
  }

  Future<void> updateUser(
      {required int id, required String name, int? age}) async {
    _editedUser = UserModel(id: id, name: name, age: age);
    final repo = await ref.read(userRepositoryProvider.future);
    await repo.update(_editedUser!);
    ref.invalidateSelf();
  }

  Future<void> delete({required int? id}) async {
    _editedUser = await getById(id: id ?? 0);
    if (_editedUser != null) {
      final repo = await ref.read(userRepositoryProvider.future);
      await repo.delete(id!);
    }
    ref.invalidateSelf();
  }

  // Future<void> sort(String field) async {
  //   final repo = await ref.read(userRepositoryProvider.future);
  //   final itens = await repo.sort(field);
  //   state = AsyncData(itens);
  // }
}
