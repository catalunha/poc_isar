import 'package:poc_isar/app/data/config/providers.dart';
import 'package:poc_isar/app/data/remote/dio/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/local/isar/providers.dart';
import 'user_repository.dart';
import 'user_repository_api.dart';
import 'user_repository_isar.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
Future<UserRepository> userRepository(UserRepositoryRef ref) async {
  final configController = ref.read(configControllerProvider);

  if (configController.getAPI) {
    return UserRepositoryApi(
      dioClient: ref.read(dioClientProvider),
    );
  } else {
    return UserRepositoryIsar(
      isarDb: await ref.read(isarDbProvider.future),
    );
  }
}
