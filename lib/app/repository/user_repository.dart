import '../model/user_model.dart';

abstract class UserRepository {
  Future<int?> create(UserModel model);
  Future<List<UserModel>> getall();
  Future<UserModel?> getById(int id);
  Future<void> update(UserModel model);
  Future<void> delete(int id);
}
