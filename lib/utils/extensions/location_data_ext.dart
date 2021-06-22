import 'dart:math';

import 'package:background_location/background_location.dart';
import 'package:location/location.dart' as loc;
import 'package:wepark/data/model/entities/element_entity/element_entity.dart';

extension LocationDataExt on loc.LocationData {
  LatLng get latLng => LatLng.fromLocationData(this);
}

extension LocationBackgroundExt on Location {
  LatLng get latLng => LatLng.fromLocationBackgroundData(this);
}

extension LatLngExt on LatLng {
  double distanceBetween(LatLng endLatLang) {
    var endLatitude = endLatLang.latitude;
    var endLongitude = endLatLang.longitude;
    var earthRadius = 6378137.0;
    var dLat = _toRadians(endLatitude - latitude);
    var dLon = _toRadians(endLongitude - longitude);

    var a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) *
            cos(_toRadians(latitude)) *
            cos(_toRadians(endLatitude));
    var c = 2 * asin(sqrt(a));

    return (earthRadius * c).abs();
  }

  _toRadians(double degree) {
    return degree * pi / 180;
  }
}


_doSort(List<ElementEntity> list) {
  final listSort = list.sort((a, b) => a.center.distanceBetween(b.center).toInt());
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);

  factory LatLng.fromLocationData(loc.LocationData data) {
    return LatLng(data.latitude, data.longitude);
  }

  factory LatLng.fromLocationBackgroundData(Location location) {
    return LatLng(location.latitude, location.longitude);
  }

  @override
  String toString() {
    return 'LatLng{latitude: $latitude, longitude: $longitude}';
  }
}
