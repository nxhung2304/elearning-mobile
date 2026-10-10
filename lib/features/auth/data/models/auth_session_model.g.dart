// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) =>
    AuthSessionModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: (json['expires_in'] as num).toInt(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthSessionModelToJson(AuthSessionModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
      'user': instance.user,
    };

const _$AuthSessionModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'access_token': {'type': 'string'},
    'refresh_token': {'type': 'string'},
    'expires_in': {'type': 'integer'},
    'user': {r'$ref': r'#/$defs/UserModel'},
  },
  'required': ['access_token', 'refresh_token', 'expires_in', 'user'],
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
