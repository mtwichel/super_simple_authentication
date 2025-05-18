// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) =>
    SignInRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      token: json['token'] as String?,
      error: $enumDecodeNullable(_$SignInErrorEnumMap, json['error']),
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$SignInResponseToJson(
  SignInResponse instance,
) => <String, dynamic>{
  if (instance.token case final value?) 'token': value,
  if (_$SignInErrorEnumMap[instance.error] case final value?) 'error': value,
  if (instance.refreshToken case final value?) 'refresh_token': value,
};

const _$SignInErrorEnumMap = {
  SignInError.invalidCredentials: 'invalidCredentials',
  SignInError.userNotFound: 'userNotFound',
  SignInError.serverError: 'serverError',
  SignInError.unknown: 'unknown',
};
