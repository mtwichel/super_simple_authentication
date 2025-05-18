import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres_builder/postgres_builder.dart';

late PostgresBuilder database;

Future<void> init(InternetAddress ip, int port) async {
  final temp = DirectPostgresBuilder(
    debug: true,
    logger: (sql) {
      // ignore: avoid_print
      print(sql);
    },
    customTypeConverter: (input) {
      if (input is DateTime) {
        return input.toUtc().toIso8601String();
      }
      return input;
    },
  );
  final host = Platform.environment['POSTGRES_HOST'];
  final port = Platform.environment['POSTGRES_PORT'];
  final databaseName = Platform.environment['POSTGRES_DATABASE'];
  final username = Platform.environment['POSTGRES_USERNAME'];
  final password = Platform.environment['POSTGRES_PASSWORD'];
  if (host == null ||
      port == null ||
      databaseName == null ||
      username == null ||
      password == null) {
    throw Exception('Missing environment variables');
  }
  await temp.initialize(
    endpoint: Endpoint(
      host: host,
      port: int.parse(port),
      database: databaseName,
      username: username,
      password: password,
    ),
  );
  database = temp;

  final createTablesSql = File(
    'sql/create_tables.sql',
  ).readAsStringSync().split('--').map((e) => e.trim()).toList();
  for (final sql in createTablesSql) {
    await database.rawExecute(sql);
  }
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, ip, port);
}
