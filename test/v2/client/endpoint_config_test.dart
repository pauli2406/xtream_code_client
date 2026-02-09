import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';
import 'package:xtream_code_client/src/v2/core/request_exception.dart';

void main() {
  test('uses configured endpoint paths and default query parameters', () async {
    Uri? playerRequestUri;
    Uri? xmltvRequestUri;

    final mock = MockClient((request) async {
      if (request.url.path.endsWith('/custom/player.php')) {
        playerRequestUri = request.url;
        return Response('[]', 200);
      }

      if (request.url.path.endsWith('/custom/xmltv.php')) {
        xmltvRequestUri = request.url;
        return Response('<tv></tv>', 200);
      }

      return Response('[]', 200);
    });

    final client = XtreamClient(
      url: 'https://example.com',
      username: 'user',
      password: 'pass',
      httpClient: mock,
      endpointConfig: const EndpointConfig(
        playerApiPath: 'custom/player.php',
        xmltvPath: 'custom/xmltv.php',
        playlistPath: 'custom/get.php',
        defaultQueryParameters: <String, String>{'token': 'abc'},
      ),
    );

    final baseUri = Uri.parse(client.baseUrl);
    expect(baseUri.path, '/custom/player.php');
    expect(baseUri.queryParameters['token'], 'abc');
    expect(baseUri.queryParameters['username'], 'user');
    expect(baseUri.queryParameters['password'], 'pass');

    await client.liveStreamCategoriesData();
    await client.epgLiteData();

    expect(playerRequestUri, isNotNull);
    expect(playerRequestUri!.queryParameters['token'], 'abc');
    expect(playerRequestUri!.queryParameters['action'], 'get_live_categories');
    expect(playerRequestUri!.queryParameters['username'], 'user');
    expect(playerRequestUri!.queryParameters['password'], 'pass');

    expect(xmltvRequestUri, isNotNull);
    expect(xmltvRequestUri!.queryParameters['token'], 'abc');
    expect(xmltvRequestUri!.queryParameters['username'], 'user');
    expect(xmltvRequestUri!.queryParameters['password'], 'pass');
  });

  test('request exception message redacts sensitive credentials', () async {
    final mock = MockClient((request) async {
      return Response('server error', 500);
    });

    final client = XtreamClient(
      url: 'https://example.com',
      username: 'secret-user',
      password: 'secret-pass',
      httpClient: mock,
      endpointConfig: const EndpointConfig(
        defaultQueryParameters: <String, String>{
          'token': 'secret-token',
        },
      ),
    );

    try {
      await client.liveStreamCategoriesData();
      fail('Expected RequestException');
    } catch (error) {
      expect(error, isA<RequestException>());
      final message = error.toString();

      expect(message, contains('status code 500'));
      expect(message, contains('action=get_live_categories'));

      expect(message, isNot(contains('secret-user')));
      expect(message, isNot(contains('secret-pass')));
      expect(message, isNot(contains('secret-token')));
    }
  });
}
