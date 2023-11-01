import 'package:get_it/get_it.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {
  sl
    ..registerFactory(
      () => AuthenticationBloc(createUser: sl(), getUsers: sl()),
    )
    ..registerLazySingleton(
      () => CreateUser(sl()),
    )
    ..registerLazySingleton(
      () => GetUsers(sl()),
    )
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementation(sl()),
    )
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthRemoteDataSrcImpl(sl()),
    )
    ..registerLazySingleton(
      http.Client.new,
    );
}
