// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElementEntity _$ElementEntityFromJson(Map<String, dynamic> json) {
  return ElementEntity(
    json['elementId'] == null
        ? null
        : ElementId.fromJson(json['elementId'] as Map<String, dynamic>),
    json['type'] as String,
    json['name'] as String,
    json['active'] as bool,
    json['createdTimestamp'] == null
        ? null
        : DateTime.parse(json['createdTimestamp'] as String),
    json['createdBy'] == null
        ? null
        : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
    json['elementAttributes'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ElementEntityToJson(ElementEntity instance) =>
    <String, dynamic>{
      'elementId': instance.elementId,
      'type': instance.type,
      'name': instance.name,
      'active': instance.active,
      'createdTimestamp': instance.createdTimestamp?.toIso8601String(),
      'createdBy': instance.createdBy,
      'elementAttributes': instance.elementAttributes,
    };
