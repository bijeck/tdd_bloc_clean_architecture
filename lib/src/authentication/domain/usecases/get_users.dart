import 'package:injectable/injectable.dart';
import 'package:tdd_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:tdd_bloc_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';

@LazySingleton()
class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this.repository);

  final AuthenticationRepository repository;

  @override
  ResultFuture<List<User>> call() => repository.getUser();
}
