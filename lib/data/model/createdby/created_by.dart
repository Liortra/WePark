import 'package:wepark/data/model/userid/user_id.dart';
import 'package:json_annotation/json_annotation.dart';
part 'created_by.g.dart';

@JsonSerializable()
class CreatedBy {
  UserId userId;

  CreatedBy(this.userId);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

  factory CreatedBy.fromJson(Map<String, dynamic> item) =>
      _$CreatedByFromJson(item);
}
