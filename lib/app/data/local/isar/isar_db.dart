// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';

// import '../../../model/user_model.dart';

// class IsarDB {
//   Isar? _isardb;
//   Future<Isar> open() async {
//     if (_isardb == null) {
//       final dir = await getApplicationDocumentsDirectory();
//       _isardb = await Isar.open(
//         [UserModelSchema],
//         directory: dir.path,
//         inspector: true,
//         name: 'isardb',
//       );
//     }
//     return _isardb!;
//   }
// }
