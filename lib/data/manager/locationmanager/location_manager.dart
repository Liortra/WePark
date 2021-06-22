import 'dart:async';
import 'dart:io';

import 'package:background_location/background_location.dart' as locBackground;
import 'package:location/location.dart';
import 'package:wepark/utils/extensions/location_data_ext.dart';
import 'package:wepark/utils/extensions/location_data_ext.dart';
import 'location_state.dart';

class LocationManager {
  final _location = Location();
  final locationPermissionStream = StreamController<LocationSensorPermissionState>.broadcast();
  final locationStreamController = StreamController<BaseLocationState>.broadcast();

  ///
  /// Check permission location and sensor first
  ///
  Future<LocationSensorPermissionState> checkPermissionGranted() async {
    final sensorEnable = await _location.serviceEnabled();
    if (!sensorEnable) return LocationSensorPermissionState.SENSOR_NOT_ACTIVE;
    final permissionGranted = await _location
        .hasPermission()
        .then((status) => status == PermissionStatus.granted);
    if (!permissionGranted) return LocationSensorPermissionState.PERMISSION_NOT_GRANTED;
    return LocationSensorPermissionState.ALL_WORKING;
  }

  observeLocationPermission() {
    Stream.periodic(Duration(seconds: 1))
        .asyncMap((_) => checkPermissionGranted())
        .distinct()
        .listen((event) => locationPermissionStream.add(event),
            onError: (e) => print("error while observe location permission"));
  }

  ///This is another library do not confused!
  activeLocationService() async {
    // await locBackground.BackgroundLocation.setAndroidNotification(title: "WePark",message:"BackgroundLocation",icon: "@mipmap/ic_launcher");
    // await locBackground.BackgroundLocation.setAndroidConfiguration(interval: 1000);
    // await locBackground.BackgroundLocation.startLocationService();
    // try {
    //   locBackground.BackgroundLocation.getLocationUpdates((data) {
    //     print("show location change: ${data.latLng}");
    //     locationStreamController.add(LocationDataResultState(data));
    //   });
    // } catch(e) {
    //   print("~~~~~~~~~ error : $e ~~~~~~~~~~");
    //   locationStreamController.add(LocationErrorState(e.toString(), e));
    // }

    _location
      ..enableBackgroundMode(enable: true)
      ..changeSettings(accuracy: Platform.isIOS ? LocationAccuracy.navigation : LocationAccuracy.high)
      ..onLocationChanged.distinct().listen(
          (data) {
            print("show location change: ${data.latLng}");
            locationStreamController.add(LocationDataResultState(data));
          },
          onError: (e) {
        print("~~~~~~~~~ error : $e ~~~~~~~~~~");
        locationStreamController.add(LocationErrorState(e.toString(), e));
      });
  }
  /// Gets the current location of the user.
  Future<LocationData> getLastLocation() => _location.getLocation();

  Future<LatLng> getLastLatLng() => getLastLocation().then((value) => value.latLng);

   stopService() async{
    // await _location.enableBackgroundMode(enable:false);
   }
}
