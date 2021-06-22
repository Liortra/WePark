import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable()
class Location {
  double lat;
  double lng;


  Location(this.lat, this.lng);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  factory Location.fromJson(Map<String, dynamic> item) =>
      _$LocationFromJson(item);
}
