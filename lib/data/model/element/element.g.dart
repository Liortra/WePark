// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Element _$ElementFromJson(Map<String, dynamic> json) {
  return Element(
    json['elementId'] == null
        ? null
        : ElementId.fromJson(json['elementId'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ElementToJson(Element instance) => <String, dynamic>{
      'elementId': instance.elementId,
    };
