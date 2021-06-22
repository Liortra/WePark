import 'package:wepark/data/manager/locationmanager/location_state.dart';

abstract class BaseMainState {}
class MainInitialState extends BaseMainState {}
class LocationPermissionState extends BaseMainState {
  final LocationSensorPermissionState locationState;

  LocationPermissionState(this.locationState);
}
class MainLogout extends BaseMainState {}