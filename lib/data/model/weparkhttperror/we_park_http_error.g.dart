// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'we_park_http_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeParkHttpError _$WeParkHttpErrorFromJson(Map<String, dynamic> json) {
  return WeParkHttpError(
    json['status'] as int,
    json['error'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$WeParkHttpErrorToJson(WeParkHttpError instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
    };
