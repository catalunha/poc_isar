import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poc_isar/app/data/local/isar/isar_db.dart';
import 'package:poc_isar/app/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<Isar> isarDb(IsarDbRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isardb = await Isar.open(
    [UserModelSchema],
    directory: dir.path,
    // inspector: true,
    name: 'isardb',
  );
  if (isardb.isOpen) {
    log('isarDb is Open!!', name: 'isarDb');
  }
  return isardb;
}
