import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/usecases/get_users.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;
  late GetUsers usecase;
  setUp(() {
    authenticationRepository = MockAuthRepo();
    usecase = GetUsers(authenticationRepository);
  });

  const tResponse = [User.empty()];

  test('Call to AuthRepo.getUsers', () async {
    when(
      () => authenticationRepository.getUser(),
    ).thenAnswer((_) async => const Right(tResponse));

    final result = await usecase();

    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
    verify(
      () => authenticationRepository.getUser(),
    ).called(1);

    verifyNoMoreInteractions(authenticationRepository);
  });
}
