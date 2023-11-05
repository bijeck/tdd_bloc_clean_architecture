import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tdd_bloc_clean_architecture/core/errors/exceptions.dart';
import 'package:tdd_bloc_clean_architecture/core/errors/failure.dart';
import 'package:tdd_bloc_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar,);
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUser() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
