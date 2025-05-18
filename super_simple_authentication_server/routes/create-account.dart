import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres_builder/postgres_builder.dart';
import 'package:shared_objects/shared_objects.dart';
import 'package:super_simple_authentication_server/src/create_jwt.dart';
import 'package:super_simple_authentication_server/src/create_refresh_token.dart';
import 'package:super_simple_authentication_server/src/map_extension.dart';
import 'package:super_simple_authentication_server/src/password_hashing.dart';

Future<Response> onRequest(RequestContext context) async {
  final requestBody = await context.request.parse(
    CreateAccountRequest.fromJson,
  );

  final database = context.read<PostgresBuilder>();
  final hashedPassword = await calculatePasswordHash(requestBody.password);
  final userId = await database.mappedSingleQuery(
    Insert(
      [
        {
          'email': requestBody.email,
          'password': base64.encode(hashedPassword.hash),
          'salt': base64.encode(hashedPassword.salt),
        },
      ],
      into: 'users',
    ),
    fromJson: (row) => row['id'] as String,
  );

  final jwt = await createJwt(subject: userId);
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
    body: CreateAccountResponse(token: jwt, refreshToken: refreshToken),
  );
}
