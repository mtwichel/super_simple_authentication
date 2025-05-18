// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenRequest _$RefreshTokenRequestFromJson(Map<String, dynamic> json) =>
    RefreshTokenRequest(refreshToken: json['refresh_token'] as String);

Map<String, dynamic> _$RefreshTokenRequestToJson(
  RefreshTokenRequest instance,
) => <String, dynamic>{'refresh_token': instance.refreshToken};

RefreshTokenResponse _$RefreshTokenResponseFromJson(
  Map<String, dynamic> json,
) => RefreshTokenResponse(
  token: json['token'] as String?,
  refreshToken: json['refresh_token'] as String?,
  error: $enumDecodeNullable(_$RefreshTokenErrorEnumMap, json['error']),
);

Map<String, dynamic> _$RefreshTokenResponseToJson(
  RefreshTokenResponse instance,
) => <String, dynamic>{
  if (instance.token case final value?) 'token': value,
  if (instance.refreshToken case final value?) 'refresh_token': value,
  if (_$RefreshTokenErrorEnumMap[instance.error] case final value?)
    'error': value,
};

const _$RefreshTokenErrorEnumMap = {
  RefreshTokenError.revoked: 'revoked',
  RefreshTokenError.invalid: 'invalid',
  RefreshTokenError.unknown: 'unknown',
};
