import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/xtream_code_client.dart';

void main() {
  group('XtreamCode Client Tests', () {
    tearDown(() async {
      // Clean up after each test if instance is initialized
      try {
        await XtreamCode.instance.dispose();
      } catch (e) {
        // Instance not initialized, nothing to clean up
      }
    });

    test('should create URLs with port when port is provided', () async {
      const url = 'https://example.com';
      const port = '8080';
      const username = 'testuser';
      const password = 'testpass';

      await XtreamCode.initialize(
        url: url,
        port: port,
        username: username,
        password: password,
      );

      final client = XtreamCode.instance.client;

      expect(client.baseUrl, '$url:$port/player_api.php?username=$username&password=$password');
    });

    test('should create URLs without port when port is null', () async {
      const url = 'https://example.com';
      const username = 'testuser';
      const password = 'testpass';

      await XtreamCode.initialize(
        url: url,
        port: null,
        username: username,
        password: password,
      );

      final client = XtreamCode.instance.client;

      expect(client.baseUrl, '$url/player_api.php?username=$username&password=$password');
    });

    test('should create URLs without port when port is empty string', () async {
      const url = 'https://example.com';
      const port = '';
      const username = 'testuser';
      const password = 'testpass';

      await XtreamCode.initialize(
        url: url,
        port: port,
        username: username,
        password: password,
      );

      final client = XtreamCode.instance.client;

      expect(client.baseUrl, '$url/player_api.php?username=$username&password=$password');
    });
  });
}