import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_account.g.dart';

@JsonSerializable()
class CreateAccountRequest extends Equatable {
  const CreateAccountRequest({required this.email, required this.password});

  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountRequestToJson(this);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

@JsonSerializable()
class CreateAccountResponse extends Equatable {
  const CreateAccountResponse({
    required this.token,
    required this.refreshToken,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountResponseToJson(this);

  final String token;
  final String refreshToken;

  @override
  List<Object> get props => [token, refreshToken];
}
