import 'package:json_annotation/json_annotation.dart';
import 'package:wepark/data/model/userid/user_id.dart';
import 'package:wepark/data/model/user_role.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  UserId userId;
  @JsonKey(unknownEnumValue: UserRole.ACTOR) //enumm
  UserRole role;
  String username;
  String avatar;

  UserEntity.withoutLocation(
      {this.userId, this.role, this.username, this.avatar});

  UserEntity(UserId userId, UserRole role, String username, String avatar) {
    this.userId = userId;
    this.role = role;
    this.username = username;
    this.avatar = avatar;
  }

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  factory UserEntity.fromJson(Map<String, dynamic> item) =>
      _$UserEntityFromJson(item);
}
