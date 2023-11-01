import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc_clean_architecture/core/errors/exceptions.dart';
import 'package:tdd_bloc_clean_architecture/core/errors/failure.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repositoryImp;

  const tException = APIException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repositoryImp = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    test(
      'should call the [RemoteDataSource.createUser] and complete '
      'successfully when the call to the remote source is successful',
      () async {
        when(
          () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenAnswer((_) async => Future.value());

        final result = await repositoryImp.createUser(
          name: name,
          avatar: avatar,
          createdAt: createdAt,
        );

        expect(result, equals(const Right<void, void>(null)));
        verify(
          () => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return a [APIFailure] when the call to the remote '
      'source is unsuccessful',
      () async {
        when(
          () => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenThrow(tException);

        final result = await repositoryImp.createUser(
          name: name,
          avatar: avatar,
          createdAt: createdAt,
        );

        expect(
          result,
          equals(
            Left<Failure, void>(
              ApiFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );
        verify(
          () => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getUsers', () {
    test(
      'should call the [RemoteDataSource.getUsers] and return [List<User>]'
      ' when call to remote source is successful',
      () async {
        const expectedUsers = [UserModel.empty()];
        when(
          () => remoteDataSource.getUsers(),
        ).thenAnswer(
          (_) async => expectedUsers,
        );

        final result = await repositoryImp.getUser();

        expect(
          result,
          equals(const Right<void, List<UserModel>>(expectedUsers)),
        );
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return a [APIFailure] when the call to the remote '
      'source is unsuccessful',
      () async {
        when(
          () => remoteDataSource.getUsers(),
        ).thenThrow(tException);

        final result = await repositoryImp.getUser();

        expect(
          result,
          equals(Left<Failure, void>(ApiFailure.fromException(tException))),
        );
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
