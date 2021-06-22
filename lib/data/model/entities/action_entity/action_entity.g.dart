// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionEntity _$ActionEntityFromJson(Map<String, dynamic> json) {
  return ActionEntity(
    json['actionId'] == null
        ? null
        : ActionId.fromJson(json['actionId'] as Map<String, dynamic>),
    json['type'] as String,
    json['element'] == null
        ? null
        : Element.fromJson(json['element'] as Map<String, dynamic>),
    json['createdTimestamp'] == null
        ? null
        : DateTime.parse(json['createdTimestamp'] as String),
    json['invokedBy'] == null
        ? null
        : InvokedBy.fromJson(json['invokedBy'] as Map<String, dynamic>),
    json['actionAttributes'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ActionEntityToJson(ActionEntity instance) =>
    <String, dynamic>{
      'actionId': instance.actionId,
      'type': instance.type,
      'element': instance.element,
      'createdTimestamp': instance.createdTimestamp?.toIso8601String(),
      'invokedBy': instance.invokedBy,
      'actionAttributes': instance.actionAttributes,
    };
