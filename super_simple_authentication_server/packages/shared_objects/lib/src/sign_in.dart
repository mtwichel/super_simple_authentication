import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in.g.dart';

@JsonSerializable()
class SignInRequest extends Equatable {
  const SignInRequest({required this.email, required this.password});

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

@JsonSerializable()
class SignInResponse extends Equatable {
  const SignInResponse({this.token, this.error, this.refreshToken});

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);

  final String? token;
  final SignInError? error;
  final String? refreshToken;

  @override
  List<Object?> get props => [token, error, refreshToken];
}

enum SignInError { invalidCredentials, userNotFound, serverError, unknown }
