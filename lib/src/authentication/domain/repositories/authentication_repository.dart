import 'package:tdd_bloc_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  ResultFuture<List<User>> getUser();
}
