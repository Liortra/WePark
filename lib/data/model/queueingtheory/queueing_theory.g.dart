// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queueing_theory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueueingTheory _$QueueingTheoryFromJson(Map<String, dynamic> json) {
  return QueueingTheory(
    (json['generalQuantity'] as num)?.toDouble(),
    (json['arrivalRate'] as num)?.toDouble(),
    (json['totalTimeInSystem'] as num)?.toDouble(),
    (json['averageQueueQuantity_q'] as num)?.toDouble(),
    (json['averageWaitingTime_q'] as num)?.toDouble(),
    (json['serviceRate'] as num)?.toDouble(),
    (json['averageServiceDuration'] as num)?.toDouble(),
    json['servers'] as int,
    (json['overload'] as num)?.toDouble(),
    (json['getServiceImmediately'] as num)?.toDouble(),
    (json['w_t'] as num)?.toDouble(),
    (json['r'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$QueueingTheoryToJson(QueueingTheory instance) =>
    <String, dynamic>{
      'generalQuantity': instance.generalQuantity,
      'arrivalRate': instance.arrivalRate,
      'totalTimeInSystem': instance.totalTimeInSystem,
      'averageQueueQuantity_q': instance.averageQueueQuantity_q,
      'averageWaitingTime_q': instance.averageWaitingTime_q,
      'serviceRate': instance.serviceRate,
      'averageServiceDuration': instance.averageServiceDuration,
      'servers': instance.servers,
      'overload': instance.overload,
      'getServiceImmediately': instance.getServiceImmediately,
      'w_t': instance.w_t,
      'r': instance.r,
    };
