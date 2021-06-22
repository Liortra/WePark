//import 'package:background_location/background_location.dart';
import 'package:location/location.dart';

abstract class BaseLocationState {}

class LocationDataResultState extends BaseLocationState {
  final LocationData data;
  LocationDataResultState(this.data);
}

class LocationErrorState extends BaseLocationState {
  final String message;
  final dynamic e;

  LocationErrorState(this.message, this.e);
}

enum LocationSensorPermissionState{
  SENSOR_NOT_ACTIVE,
  PERMISSION_NOT_GRANTED,
  ALL_WORKING
}

