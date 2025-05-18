import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_objects/shared_objects.dart';

/// {@template super_simple_authentication_client}
/// A client for the Super Simple Authentication API
/// {@endtemplate}
class SuperSimpleAuthenticationClient {
  /// {@macro super_simple_authentication_client}
  SuperSimpleAuthenticationClient({
    required String baseUrl,
    Client? client,
  })  : _client = client ?? Client(),
        _baseUrl = baseUrl;

  final Client _client;
  final String _baseUrl;

  /// Creates a new account.
  Future<CreateAccountResponse> createAccount({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/create-account'),
      body: CreateAccountRequest(email: email, password: password),
    );
    return CreateAccountResponse.fromJson(response.bodyMap);
  }

  /// Signs in a user.
  Future<SignInResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/sign-in'),
      body: SignInRequest(email: email, password: password),
    );
    return SignInResponse.fromJson(response.bodyMap);
  }

  /// Refreshes a user's session.
  Future<RefreshTokenResponse> refreshToken({
    required String refreshToken,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/refresh-token'),
      body: RefreshTokenRequest(refreshToken: refreshToken),
    );
    return RefreshTokenResponse.fromJson(response.bodyMap);
  }
}

extension on Response {
  Map<String, dynamic> get bodyMap =>
      Map<String, dynamic>.from(jsonDecode(body) as Map);
}
