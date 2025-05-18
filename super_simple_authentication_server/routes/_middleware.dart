import 'package:dart_frog/dart_frog.dart';
import 'package:postgres_builder/postgres_builder.dart';

import '../main.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<PostgresBuilder>((_) => database));
}
