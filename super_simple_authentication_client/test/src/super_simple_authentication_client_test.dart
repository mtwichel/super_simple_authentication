// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_simple_authentication_client/super_simple_authentication_client.dart';
import 'package:test/test.dart';

class _MockClient extends Mock implements Client {}

const baseUrl = 'https://invalid.invalid';

void main() {
  group('SuperSimpleAuthenticationClient', () {
    late Client client;

    setUp(() {
      client = _MockClient();
    });

    test('can be instantiated', () {
      expect(
        SuperSimpleAuthenticationClient(
          baseUrl: baseUrl,
        ),
        isNotNull,
      );
    });

    group('createAccount', () {
      test('throws an error if the client is not able to connect to the server',
          () {
        when(() => client.post(Uri.parse(baseUrl), body: any(named: 'body')))
            .thenThrow(Exception('Connection failed'));

        expect(
          () => SuperSimpleAuthenticationClient(baseUrl: baseUrl)
              .createAccount(email: 'test@example.com', password: 'password'),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
