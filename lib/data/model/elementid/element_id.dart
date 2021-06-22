import 'package:json_annotation/json_annotation.dart';

part 'element_id.g.dart';

@JsonSerializable()
class ElementId {
  String domain;
  String id;

  ElementId(this.domain, this.id);

  Map<String, dynamic> toJson() => _$ElementIdToJson(this);

  factory ElementId.fromJson(Map<String, dynamic> item) =>
      _$ElementIdFromJson(item);
}
