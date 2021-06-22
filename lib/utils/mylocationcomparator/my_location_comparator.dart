import 'dart:core';

import 'package:wepark/data/model/entities/element_entity/element_entity.dart';
import 'package:wepark/utils/extensions/location_data_ext.dart';
import 'package:wepark/utils/parkingspaces/wepark_parking_spaces.dart';
import 'package:wepark/utils/extensions/location_data_ext.dart';


class MyLocationComparator{

  static List<MockPark> startSort(List<MockPark> list,LatLng myLocation){
    list.sort((p1,p2){
      final distance1 = myLocation.distanceBetween(p1.center);
      final distance2 = myLocation.distanceBetween(p2.center);
      return (distance1-distance2).toInt();
    });
    return list;
  }

  static List<ElementEntity> startSortParking(List<ElementEntity> list,LatLng myLocation){
    list.sort((p1,p2){
      final distance1 = myLocation.distanceBetween(p1.center);
      final distance2 = myLocation.distanceBetween(p2.center);
      return (distance1-distance2).toInt();
    });
    return list;
  }
}