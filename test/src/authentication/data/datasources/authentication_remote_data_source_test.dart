import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc_clean_architecture/core/errors/exceptions.dart';
import 'package:tdd_bloc_clean_architecture/core/utils/constants.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource authRemoteDataSrc;

  setUp(() {
    client = MockClient();
    authRemoteDataSrc = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group(
    'createUser',
    () {
      test(
        'should complete successfully when the status code is 200 or 201',
        () async {
          when(
            () => client.post(
              any(),
              body: any(named: 'body'),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response('User created successfully', 201),
          );

          final methodCall = authRemoteDataSrc.createUser;

          expect(
            methodCall(
              createdAt: 'createdAt',
              name: 'name',
              avatar: 'avatar',
            ),
            completes,
          );

          verify(
            () => client.post(
              Uri.https(kBaseUrl, kCreateUserEndpoint),
              body: jsonEncode({
                'avatar': 'avatar',
                'createdAt': 'createdAt',
                'name': 'name',
              }),
              headers: {'Content-Type': 'application/json'},
            ),
          ).called(1);
          verifyNoMoreInteractions(client);
        },
      );
      test(
        'should throw [APIException] when the status code is not 200 or '
        '201',
        () async {
          when(
            () => client.post(
              any(),
              body: any(named: 'body'),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response('Invalid email address', 400),
          );

          final methodCall = authRemoteDataSrc.createUser;

          expect(
            () async => methodCall(
              createdAt: 'createdAt',
              name: 'name',
              avatar: 'avatar',
            ),
            throwsA(
              const APIException(
                message: 'Invalid email address',
                statusCode: 400,
              ),
            ),
          );

          verify(
            () => client.post(
              Uri.https(kBaseUrl, kCreateUserEndpoint),
              body: jsonEncode({
                'avatar': 'avatar',
                'createdAt': 'createdAt',
                'name': 'name',
              }),
              headers: {'Content-Type': 'application/json'},
            ),
          ).called(1);
          verifyNoMoreInteractions(client);
        },
      );
    },
  );

  group(
    'getUsers',
    () {
      const tUsers = [UserModel.empty()];
      test(
        'should return [List<User>] when the status code is 200',
        () async {
          when(
            () => client.get(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
          );

          final result = await authRemoteDataSrc.getUsers();

          expect(result, equals(tUsers));

          verify(
            () => client.get(
              Uri.https(kBaseUrl, kGetUsersEndpoint),
              headers: any(named: 'headers'),
            ),
          ).called(1);

          verifyNoMoreInteractions(client);
        },
      );

      test(
        'should throw [APIException] when the status code is not 200',
        () async {
          when(
            () => client.get(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response('Error in server', 400),
          );

          final result = authRemoteDataSrc.getUsers;

          expect(
            () => result(),
            throwsA(
              const APIException(
                message: 'Error in server',
                statusCode: 400,
              ),
            ),
          );
          verify(() => client.get(
                Uri.https(kBaseUrl, kGetUsersEndpoint),
                headers: {'Content-Type': 'application/json'},
              )).called(1);
          verifyNoMoreInteractions(client);
        },
      );
    },
  );
}
