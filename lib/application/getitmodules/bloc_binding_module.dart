import 'package:get_it/get_it.dart';
import 'package:wepark/pages/home/list/list_bloc.dart';
import 'package:wepark/pages/home/main/main_bloc.dart';
import 'package:wepark/pages/home/result/result_bloc.dart';
import 'package:wepark/pages/home/scan/scan_bloc.dart';
import 'package:wepark/pages/home/unpark/unpark_bloc.dart';
import 'package:wepark/pages/login/login_bloc.dart';
import 'package:wepark/pages/registration/registration_bloc.dart';
import 'package:wepark/pages/settings/settings_bloc.dart';

class BlocBindingModule {
  static providesBlocsModule() {
    GetIt.I.registerFactory(() => RegistrationBloc(GetIt.I.get()));
    GetIt.I.registerFactory(() => LoginBloc(GetIt.I.get()));
    GetIt.I.registerFactory(() => SettingsBloc(GetIt.I.get()));
    GetIt.I.registerFactory(() => ScanBloc(GetIt.I.get(),GetIt.I.get(),GetIt.I.get()));
    GetIt.I.registerFactory(() => ResultBloc(GetIt.I.get(),GetIt.I.get(),GetIt.I.get()));
    GetIt.I.registerFactory(() => UnParkBloc(GetIt.I.get(),GetIt.I.get(),GetIt.I.get()));
    GetIt.I.registerFactory(() => ListBloc(GetIt.I.get(),GetIt.I.get()));
    GetIt.I.registerFactory(() => MainBloc(GetIt.I.get(),GetIt.I.get()));
  }
}
