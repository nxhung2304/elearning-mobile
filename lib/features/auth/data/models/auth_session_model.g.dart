// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) =>
    AuthSessionModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthSessionModelToJson(AuthSessionModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
    };

const _$AuthSessionModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'accessToken': {'type': 'string'},
    'refreshToken': {'type': 'string'},
    'expiresIn': {'type': 'integer'},
    'user': {r'$ref': r'#/$defs/UserModel'},
  },
  'required': ['accessToken', 'refreshToken', 'expiresIn', 'user'],
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
