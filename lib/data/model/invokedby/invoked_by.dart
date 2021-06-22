import 'package:wepark/data/model/userid/user_id.dart';

import 'package:json_annotation/json_annotation.dart';

part 'invoked_by.g.dart';

@JsonSerializable()
class InvokedBy {
  UserId userId;

  InvokedBy(this.userId);

  Map<String, dynamic> toJson() => _$InvokedByToJson(this);

  factory InvokedBy.fromJson(Map<String, dynamic> item) =>
      _$InvokedByFromJson(item);
}
