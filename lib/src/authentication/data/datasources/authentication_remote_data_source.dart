import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:tdd_bloc_clean_architecture/core/errors/exceptions.dart';
import 'package:tdd_bloc_clean_architecture/core/utils/constants.dart';
import 'package:tdd_bloc_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndpoint = '/test-api/users';

@LazySingleton(as: AuthenticationRemoteDataSource)
class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;
  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar,}) async {
    try {
      final response =
          await _client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
              body: jsonEncode({
                'avatar': avatar,
                'createdAt': createdAt,
                'name': name,
              }),
              headers: {'Content-Type': 'application/json'},);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          headers: {'Content-Type': 'application/json'},);
      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map(UserModel.fromMap)
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
