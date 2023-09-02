import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:poc_isar/app/data/remote/dio/dio_client.dart';

import 'package:poc_isar/app/repository/user_repository.dart';

import '../model/user_model.dart';

class UserRepositoryApi extends UserRepository {
  final DioClient dioClient;

  UserRepositoryApi({
    required this.dioClient,
  });
  @override
  Future<List<UserModel>> getall() async {
    try {
      final Response(:List data) = await dioClient.unauth.get('/api/data1/');
      print('data');
      print(data);
      print('map');
      print(data.map((e) => UserModel.fromMap(e)).toList());
      return data.map<UserModel>((e) => UserModel.fromMap(e)).toList();
      // return UserModel.fromJson(data);
    } on DioException catch (e, s) {
      log('DioException em UserRepositoryApi.getall', error: e, stackTrace: s);
    } catch (e, s) {
      log('Erro Qq em UserRepositoryApi.getall', error: e, stackTrace: s);
    }
    return [];
  }

  @override
  Future<UserModel?> getById(int id) async {
    try {
      final Response(:data) = await dioClient.unauth.get('/api/data1/$id');
      if (data != null) {
        return UserModel.fromMap(data);
      }
    } on DioException catch (e, s) {
      log('DioException em UserRepositoryApi.getById', error: e, stackTrace: s);
    }
    return null;
  }

  @override
  Future<int?> create(UserModel model) async {
    try {
      final Response(:data) =
          await dioClient.unauth.post('/api/data1/', data: model.toJson());
      if (data != null) {
        final userCreated = UserModel.fromMap(data);
        return userCreated.id!;
      }
    } on DioException catch (e, s) {
      log('DioException em UserRepositoryApi.create', error: e, stackTrace: s);
    }
    return null;
  }

  @override
  Future<void> update(UserModel model) async {
    try {
      await dioClient.unauth
          .patch('/api/data1/${model.id}/', data: model.toJson());
      // if (data != null) {
      //   final userCreated = UserModel.fromMap(data);
      //   return userCreated.id!;
      // }
      print('Chamando update');
    } on DioException catch (e, s) {
      log('DioException em UserRepositoryApi.update', error: e, stackTrace: s);
    }
    return;
  }

  @override
  Future<void> delete(int id) async {}

  // Future<List<UserModel>> sort(String field) async {
  //   return switch (field) {
  //     'Name' => isarDb.userModels.where().sortByName().findAll(),
  //     'Age' => isarDb.userModels.where().sortByAge().findAll(),
  //     _ => isarDb.userModels.where().findAll()
  //   };
  // }
}
