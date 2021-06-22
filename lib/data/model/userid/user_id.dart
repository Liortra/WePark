import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_id.g.dart';

@JsonSerializable()
class UserId {
  String domain;
  String email;

 UserId(this.email,this.domain);

  Map<String, dynamic> toJson() => _$UserIdToJson(this);

  factory UserId.fromJson(Map<String, dynamic> item) => _$UserIdFromJson(item);
}
