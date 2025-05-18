import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token.g.dart';

@JsonSerializable()
class RefreshTokenRequest extends Equatable {
  const RefreshTokenRequest({required this.refreshToken});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);
  final String refreshToken;

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);

  @override
  List<Object> get props => [refreshToken];
}

@JsonSerializable()
class RefreshTokenResponse extends Equatable {
  const RefreshTokenResponse({this.token, this.refreshToken, this.error});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);
  final String? token;
  final String? refreshToken;
  final RefreshTokenError? error;
  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);

  @override
  List<Object?> get props => [token, refreshToken, error];
}

enum RefreshTokenError { revoked, invalid, unknown }
