import 'package:json_annotation/json_annotation.dart';
import 'package:wepark/data/model/createdby/created_by.dart';
import 'package:wepark/data/model/elementid/element_id.dart';
import 'package:wepark/data/model/location/location.dart';
import  'package:dart_extensions/dart_extensions.dart';
import 'package:wepark/data/model/userid/user_id.dart';
import 'package:wepark/utils/extensions/location_data_ext.dart';
import 'package:wepark/utils/parkingspaces/wepark_parking_spaces.dart';
part 'element_entity.g.dart';

@JsonSerializable()
class ElementEntity {
  ElementId elementId;
  String type;
  String name;
  bool active;
  DateTime createdTimestamp;
  CreatedBy createdBy;
  // Location location;
  Map<String, Object> elementAttributes;

  ElementEntity(
      this.elementId,
      this.type,
      this.name,
      this.active,
      this.createdTimestamp,
      this.createdBy,
      // this.location,
      this.elementAttributes);

  Map<String, dynamic> toJson() => _$ElementEntityToJson(this);

  factory ElementEntity.fromJson(Map<String, dynamic> item) =>
      _$ElementEntityFromJson(item);


  factory ElementEntity.fromMockPark(MockPark mock){
    return ElementEntity(ElementId("text domain","mock id"),
        "squre",
        mock.name,
        true,
        DateTime.now(),
        CreatedBy(UserId("mock mail","mock domain")),
        {
          "averageWaitingTime_q":7.016123333333337,
          "bottom":32.11614,
          "right":34.8212,
          "top":32.11795,
          "left":34.81906,
        });
  }


  //Time variable
  double get time {
    if(elementAttributes == null || elementAttributes["averageWaitingTime_q"] == null) return 60;
    else return elementAttributes["averageWaitingTime_q"];
  }

  double get top => elementAttributes?.containsKey("top") == true ? elementAttributes["top"] : -1;
  double get left => elementAttributes?.containsKey("left") == true ? elementAttributes["left"] : -1;
  double get right => elementAttributes?.containsKey("right") == true ? elementAttributes["right"] : -1;
  double get bottom => elementAttributes?.containsKey("bottom") == true ? elementAttributes["bottom"] : -1;
  double get centerY => (top+bottom)/2;
  double get centerX => (left+right)/2;
  LatLng get center => LatLng(centerY, centerX);
}
