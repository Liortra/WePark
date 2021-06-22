import 'package:wepark/data/model/elementid/element_id.dart';
import 'package:json_annotation/json_annotation.dart';
part 'element.g.dart';

@JsonSerializable()
class Element {
  ElementId elementId;

  Element(this.elementId);

  Map<String, dynamic> toJson() => _$ElementToJson(this);

  factory Element.fromJson(Map<String, dynamic> item) =>
      _$ElementFromJson(item);
}
