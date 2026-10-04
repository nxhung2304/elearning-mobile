// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) =>
    AuthSessionModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthSessionModelToJson(AuthSessionModel instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

const _$AuthSessionModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'token': {'type': 'string'},
    'user': {r'$ref': r'#/$defs/UserModel'},
  },
  'required': ['token', 'user'],
  r'$defs': {
    'UserModel': {
      'type': 'object',
      'properties': {
        'id': {'type': 'integer'},
        'email': {'type': 'string'},
        'name': {'type': 'string'},
        'status': {'type': 'object'},
      },
      'required': ['id', 'email', 'status'],
    },
  },
};
