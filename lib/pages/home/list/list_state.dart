import 'package:wepark/data/model/entities/element_entity/element_entity.dart';
import 'package:wepark/utils/extensions/location_data_ext.dart';
import 'package:wepark/utils/parkingspaces/wepark_parking_spaces.dart';

abstract class BaseListState{}

class InitialListState extends BaseListState{}

class DisplayListMockState extends BaseListState{
  final List<MockPark> list;

  DisplayListMockState(this.list);
}

class DisplayParkingState extends BaseListState{
  final List<ElementEntity> list;
  final LatLng myLocation;

  DisplayParkingState(this.list, this.myLocation);
}

class NavigateResultState extends BaseListState {
    final LatLng latLng;

  NavigateResultState(this.latLng);

}

class ErrorListState extends BaseListState{
  final String message;
  final dynamic error;

  ErrorListState(this.message, {this.error});
}