import 'package:json_annotation/json_annotation.dart';
part 'action_id.g.dart';

@JsonSerializable()
class ActionId {
  String domain;
  String id;

  ActionId(this.domain, this.id);

  Map<String, dynamic> toJson() => _$ActionIdToJson(this);

  factory ActionId.fromJson(Map<String, dynamic> item) =>
      _$ActionIdFromJson(item);
}
