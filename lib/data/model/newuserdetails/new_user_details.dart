import 'package:json_annotation/json_annotation.dart';
import 'package:wepark/data/model/user_role.dart';

part 'new_user_details.g.dart';

@JsonSerializable()
class NewUserDetails {
  String email;
  @JsonKey(defaultValue: UserRole.ACTOR) //enum
  UserRole role;
  String username;
  String licensePlate;

  NewUserDetails(this.email, this.role, this.username, this.licensePlate);

  Map<String, dynamic> toJson() => _$NewUserDetailsToJson(this);

  factory NewUserDetails.fromJson(Map<String, dynamic> item) =>
      _$NewUserDetailsFromJson(item);
}