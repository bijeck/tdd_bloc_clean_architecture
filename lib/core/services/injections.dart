import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tdd_bloc_clean_architecture/core/services/injections.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();
