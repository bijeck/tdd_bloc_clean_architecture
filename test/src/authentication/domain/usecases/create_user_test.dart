import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/usecases/create_user.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;
  late CreateUser usecase;
  setUp(() {
    authenticationRepository = MockAuthRepo();
    usecase = CreateUser(authenticationRepository);
  });

  const params = CreateUserParams.empty();
  test('Call to AuthRepo.createUser', () async {
    when(
      () => authenticationRepository.createUser(
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
        createdAt: any(named: 'createdAt'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(params);

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => authenticationRepository.createUser(
        name: params.name,
        avatar: params.avatar,
        createdAt: params.createdAt,
      ),
    ).called(1);

    verifyNoMoreInteractions(authenticationRepository);
  });
}
