import 'dart:convert';

import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id? id;
  final String name;
  int? age;
  UserModel({
    this.id,
    required this.name,
    this.age,
  });
  UserModel copyWith({
    Id? id,
    String? name,
    int? age,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  @override
  String toString() => 'UserModel(id: $id, name: $name, age: $age)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.age == age;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ age.hashCode;

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};

  //   if(id != null){
  //     result.addAll({'id': id!.toMap()});
  //   }
  //   result.addAll({'name': name});
  //   if(age != null){
  //     result.addAll({'age': age});
  //   }

  //   return result;
  // }

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['id'] != null ? Id.fromMap(map['id']) : null,
  //     name: map['name'] ?? '',
  //     age: map['age']?.toInt(),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
