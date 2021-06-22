// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_by.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) {
  return CreatedBy(
    json['userId'] == null
        ? null
        : UserId.fromJson(json['userId'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'userId': instance.userId,
    };
