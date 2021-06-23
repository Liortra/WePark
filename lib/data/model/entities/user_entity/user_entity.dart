import 'package:json_annotation/json_annotation.dart';
import 'package:wepark/data/model/userid/user_id.dart';
import 'package:wepark/data/model/user_role.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  UserId userId;
  @JsonKey(defaultValue: UserRole.ACTOR) //enumm
  UserRole role;
  String username;
  String licensePlate;

  UserEntity(this.userId, this.role, this.username, this.licensePlate);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  factory UserEntity.fromJson(Map<String, dynamic> item) =>
      _$UserEntityFromJson(item);
}
