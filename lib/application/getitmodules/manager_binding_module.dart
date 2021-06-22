import 'package:get_it/get_it.dart';
import 'package:wepark/data/manager/locationmanager/location_manager.dart';

class ManagerBindingModule {
  static providesModules(){
    _providesLocationManager();
  }
  
  static _providesLocationManager() {
    GetIt.I.registerLazySingleton(() => LocationManager());
  }
}