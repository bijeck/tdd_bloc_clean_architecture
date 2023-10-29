import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_bloc_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test(
    'should be a subclass of [User] entity',
    () {
      expect(tModel, isA<User>());
    },
  );

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  test(
    'fromMap test',
    () {
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    },
  );

  test(
    'fromJson test',
    () {
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    },
  );

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      final result = tModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] string with the right data', () {
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty.string",
        "createdAt": "_empty.string",
        "name": "_empty.string"
      });

      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      final result = tModel.copyWith(name: 'Paul');

      expect(result.name, equals('Paul'));
    });
  });
}
