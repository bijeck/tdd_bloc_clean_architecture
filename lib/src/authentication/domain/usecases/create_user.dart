import 'package:equatable/equatable.dart';
import 'package:tdd_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:tdd_bloc_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultVoid call(dynamic params) async => _repository.createUser(
        name: (params as CreateUserParams).name,
        avatar: params.avatar,
        createdAt: params.createdAt,
      );
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  const CreateUserParams.empty()
      : this(
          avatar: '_empty.string',
          createdAt: '_empty.string',
          name: '_empty.string',
        );
  final String name;
  final String avatar;
  final String createdAt;

  @override
  List<Object?> get props => [name, avatar, createdAt];
}
