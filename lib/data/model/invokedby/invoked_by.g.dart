// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoked_by.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvokedBy _$InvokedByFromJson(Map<String, dynamic> json) {
  return InvokedBy(
    json['userId'] == null
        ? null
        : UserId.fromJson(json['userId'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InvokedByToJson(InvokedBy instance) => <String, dynamic>{
      'userId': instance.userId,
    };
