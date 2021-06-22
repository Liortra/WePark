import 'package:get_it/get_it.dart';
import 'package:wepark/data/source/action/action_data_source.dart';
import 'package:wepark/data/source/action/action_repository.dart';
import 'package:wepark/data/source/action/local/action_local_repository.dart';
import 'package:wepark/data/source/action/remote/action_remote_repository.dart';
import 'package:wepark/data/source/user/local/user_local_repository.dart';
import 'package:wepark/data/source/user/remote/user_remote_repository.dart';
import 'package:wepark/data/source/user/user_data_source.dart';
import 'package:wepark/data/source/user/user_repository.dart';

class RepositoryBindingModule {
  static provideRepositories() {
    _providesUserRepositoryModule();
    _providesActionRepositoryModule();
  }

  static _providesUserRepositoryModule(){
    GetIt.I.registerFactory<UserDataSourceRemote>(() => UserRemoteRepository(GetIt.I.get()));
    GetIt.I.registerLazySingleton<UserDataSourceLocal>(() => UserLocalRepository());
    GetIt.I.registerFactory<UserRepository>(() => UserRepository(GetIt.I.get(),GetIt.I.get()));
  }

  static _providesActionRepositoryModule() {
    GetIt.I.registerFactory<ActionDataSourceRemote>(() => ActionRemoteRepository(GetIt.I.get()));
    GetIt.I.registerLazySingleton<ActionDataSourceLocal>(() => ActionLocalRepository());
    GetIt.I.registerFactory<ActionRepository>(() => ActionRepository(GetIt.I.get(),GetIt.I.get()));
  }
}
