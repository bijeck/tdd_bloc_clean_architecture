import 'dart:convert';

import 'package:tdd_bloc_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  UserModel copyWith({
    String? createdAt,
    String? name,
    String? avatar,
    String? id,
  }) =>
      UserModel(
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        id: id ?? this.id,
      );

  factory UserModel.fromJson(String str) =>
      UserModel.fromMap(json.decode(str) as DataMap);

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(DataMap map) => UserModel(
        createdAt: map["createdAt"] as String,
        name: map["name"] as String,
        avatar: map["avatar"] as String,
        id: map["id"] as String,
      );

  DataMap toMap() => {
        "createdAt": createdAt,
        "name": name,
        "avatar": avatar,
        "id": id,
      };
}
