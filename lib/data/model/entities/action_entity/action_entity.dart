import 'package:json_annotation/json_annotation.dart';
import 'package:wepark/data/model/action/action_id.dart';
import 'package:wepark/data/model/element/element.dart';
import 'package:wepark/data/model/elementid/element_id.dart';
import 'package:wepark/data/model/entities/entities.dart';
import 'package:wepark/data/model/invokedby/invoked_by.dart';
import 'package:wepark/utils/consts/wepark_consts.dart';

part 'action_entity.g.dart';

@JsonSerializable()
class ActionEntity {
  ActionId actionId;
  String type;
  Element element;
  DateTime createdTimestamp;
  InvokedBy invokedBy;
  Map<String, Object> actionAttributes;


  ActionEntity(this.actionId, this.type, this.element, this.createdTimestamp,
      this.invokedBy, this.actionAttributes);

  factory ActionEntity.fromUserAndActionAttributesFind(UserEntity user,Map<String, dynamic> actionAttributes){
    return ActionEntity(
        ActionId(null, null),
        WeParkConsts.FIND,
        Element(ElementId("", "")),
        DateTime.now(),
        InvokedBy(user.userId),
        actionAttributes);
  }

  factory ActionEntity.park(UserEntity user,Map<String, dynamic> actionAttributes, ElementEntity elementEntity){
    return ActionEntity(
        ActionId(null, null),
        WeParkConsts.PARK,
        Element(elementEntity.elementId),
        DateTime.now(),
        InvokedBy(user.userId),
        actionAttributes);
  }

  factory ActionEntity.unPark(UserEntity user,Map<String, dynamic> actionAttributes, ElementEntity elementEntity){
    return ActionEntity(
        ActionId(null, null),
        WeParkConsts.UNPARK,
        Element(elementEntity.elementId),
        DateTime.now(),
        InvokedBy(user.userId),
        actionAttributes);
  }

  Map<String, dynamic> toJson() => _$ActionEntityToJson(this);

  factory ActionEntity.fromJson(Map<String, dynamic> item) => _$ActionEntityFromJson(item);
}
