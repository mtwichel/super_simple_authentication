import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres_builder/postgres_builder.dart';
import 'package:shared_objects/shared_objects.dart';
import 'package:super_simple_authentication_server/src/create_jwt.dart';
import 'package:super_simple_authentication_server/src/create_refresh_token.dart';
import 'package:super_simple_authentication_server/src/map_extension.dart';
import 'package:super_simple_authentication_server/src/password_hashing.dart';

Future<Response> onRequest(RequestContext context) async {
  final requestBody = await context.request.parse(SignInRequest.fromJson);

  final database = context.read<PostgresBuilder>();
  final result = await database.mappedQuery(
    Select(
      [
        const Column('password'),
        const Column('salt'),
        const Column('id', as: 'user_id'),
      ],
      from: 'users',
      where: const Column('email').equals(requestBody.email),
    ),
    fromJson: (row) => (
      password: row['password'] as String,
      salt: row['salt'] as String,
      userId: row['user_id'] as String,
    ),
  );

  if (result.isEmpty) {
    return Response.json(
      body: const SignInResponse(error: SignInError.userNotFound),
    );
  }

  final userId = result.first.userId;

  final storedPassword = base64.decode(result.first.password);
  final storedSalt = base64.decode(result.first.salt);

  final (hash: computedHash, salt: _) = await calculatePasswordHash(
    requestBody.password,
    salt: storedSalt,
  );

  if (computedHash.length != storedPassword.length) {
    return Response.json(
      body: const SignInResponse(error: SignInError.invalidCredentials),
    );
  }

  for (var i = 0; i < computedHash.length; i++) {
    if (computedHash[i] != storedPassword[i]) {
      return Response.json(
        body: const SignInResponse(error: SignInError.invalidCredentials),
      );
    }
  }
  final jwt = await createJwt(
    subject: userId,
    additionalClaims: {'email': requestBody.email},
  );

  final refreshToken = createRefreshToken(userId);

  final sessionId = await database.mappedSingleQuery(
    Insert(
      [
        {'user_id': userId},
      ],
      into: 'sessions',
    ),
    fromJson: (row) => row['id'] as String,
  );
  await database.execute(
    Insert(
      [
        {'user_id': userId, 'token': refreshToken, 'session_id': sessionId},
      ],
      into: 'refresh_tokens',
    ),
  );

  return Response.json(
    body: SignInResponse(token: jwt, refreshToken: refreshToken),
  );
}
