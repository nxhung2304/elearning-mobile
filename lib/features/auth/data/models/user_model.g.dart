// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  status: $enumDecode(_$UserModelStatusEnumMap, json['status']),
  name: json['name'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'status': _$UserModelStatusEnumMap[instance.status]!,
};

const _$UserModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'email': {'type': 'string'},
    'name': {'type': 'string'},
    'status': {'type': 'object'},
  },
  'required': ['id', 'email', 'status'],
};

const _$UserModelStatusEnumMap = {
  UserModelStatus.active: 'active',
  UserModelStatus.inactive: 'inactive',
  UserModelStatus.suspended: 'suspended',
  UserModelStatus.deleted: 'deleted',
};
