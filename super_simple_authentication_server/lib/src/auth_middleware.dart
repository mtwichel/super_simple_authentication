import 'package:dart_frog/dart_frog.dart';
import 'package:super_simple_authentication_server/src/user_id.dart';
import 'package:super_simple_authentication_server/src/verify_jwt.dart';

/// Middleware that authenticates requests using a JWT.
Handler authMiddleware(Handler handler) {
  return (context) async {
    final authorization = context.request.headers['authorization'];

    if (authorization == null) {
      final newContext = context.provide<UserId>(() => null);
      return handler(newContext);
    }
    final [_, token] = authorization.split(' ');
    final decoded = await verifyJwt(token);
    if (decoded == null) {
      final newContext = context.provide<UserId>(() => null);
      return handler(newContext);
    }
    final userId = decoded['sub'] as String?;
    if (userId == null) {
      final newContext = context.provide<UserId>(() => null);
      return handler(newContext);
    }
    final newContext = context.provide<UserId>(() => userId);
    return handler(newContext);
  };
}
