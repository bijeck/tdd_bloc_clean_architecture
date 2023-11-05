// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:tdd_bloc_clean_architecture/core/services/module.dart' as _i10;
import 'package:tdd_bloc_clean_architecture/src/authentication/data/datasources/authentication_remote_data_source.dart'
    as _i4;
import 'package:tdd_bloc_clean_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart'
    as _i6;
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart'
    as _i5;
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/usecases/create_user.dart'
    as _i7;
import 'package:tdd_bloc_clean_architecture/src/authentication/domain/usecases/get_users.dart'
    as _i8;
import 'package:tdd_bloc_clean_architecture/src/authentication/presentation/bloc/authentication_bloc.dart'
    as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.Client>(() => registerModule.httpClient);
    gh.lazySingleton<_i4.AuthenticationRemoteDataSource>(
        () => _i4.AuthRemoteDataSrcImpl(gh<_i3.Client>()));
    gh.lazySingleton<_i5.AuthenticationRepository>(() =>
        _i6.AuthenticationRepositoryImplementation(
            gh<_i4.AuthenticationRemoteDataSource>()));
    gh.lazySingleton<_i7.CreateUser>(
        () => _i7.CreateUser(gh<_i5.AuthenticationRepository>()));
    gh.lazySingleton<_i8.GetUsers>(
        () => _i8.GetUsers(gh<_i5.AuthenticationRepository>()));
    gh.factory<_i9.AuthenticationBloc>(() => _i9.AuthenticationBloc(
          createUser: gh<_i7.CreateUser>(),
          getUsers: gh<_i8.GetUsers>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
