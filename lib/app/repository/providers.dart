import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/local/isar/providers.dart';
import 'user_repository.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
Future<UserRepository> userRepository(UserRepositoryRef ref) async {
  return UserRepository(isarDb: await ref.read(isarDbProvider.future));
}
