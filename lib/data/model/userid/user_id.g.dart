// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserId _$UserIdFromJson(Map<String, dynamic> json) {
  return UserId(
    json['email'] as String,
    json['domain'] as String,
  );
}

Map<String, dynamic> _$UserIdToJson(UserId instance) => <String, dynamic>{
      'domain': instance.domain,
      'email': instance.email,
    };
