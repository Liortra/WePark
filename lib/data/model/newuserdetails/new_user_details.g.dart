// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUserDetails _$NewUserDetailsFromJson(Map<String, dynamic> json) {
  return NewUserDetails(
    json['email'] as String,
    _$enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.ACTOR,
    json['username'] as String,
    json['licensePlate'] as String,
  );
}

Map<String, dynamic> _$NewUserDetailsToJson(NewUserDetails instance) =>
    <String, dynamic>{
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role],
      'username': instance.username,
      'licensePlate': instance.licensePlate,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserRoleEnumMap = {
  UserRole.ACTOR: 'ACTOR',
  UserRole.MANAGER: 'MANAGER',
};
