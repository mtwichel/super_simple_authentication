// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountRequest _$CreateAccountRequestFromJson(
  Map<String, dynamic> json,
) => CreateAccountRequest(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$CreateAccountRequestToJson(
  CreateAccountRequest instance,
) => <String, dynamic>{'email': instance.email, 'password': instance.password};

CreateAccountResponse _$CreateAccountResponseFromJson(
  Map<String, dynamic> json,
) => CreateAccountResponse(
  token: json['token'] as String,
  refreshToken: json['refresh_token'] as String,
);

Map<String, dynamic> _$CreateAccountResponseToJson(
  CreateAccountResponse instance,
) => <String, dynamic>{
  'token': instance.token,
  'refresh_token': instance.refreshToken,
};
