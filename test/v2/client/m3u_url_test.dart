import 'package:test/test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  test('builds default m3u playlist URL', () {
    final client = XtreamClient(
      url: 'https://example.com',
      username: 'user',
      password: 'pass',
    );

    final uri = client.m3uPlaylistUri();
    expect(uri.path, '/get.php');
    expect(uri.queryParameters['username'], 'user');
    expect(uri.queryParameters['password'], 'pass');
    expect(uri.queryParameters['type'], 'm3u_plus');
    expect(uri.queryParameters['output'], 'ts');
  });

  test('builds configured m3u playlist URL with extra query parameters', () {
    final client = XtreamClient(
      url: 'https://example.com',
      username: 'user',
      password: 'pass',
      endpointConfig: const EndpointConfig(
        playlistPath: 'custom/list.php',
        defaultQueryParameters: <String, String>{'token': 'abc'},
      ),
    );

    final uri = client.m3uPlaylistUri(
      type: 'm3u',
      output: 'm3u8',
      extraQuery: const <String, String>{
        'output': 'hls',
        'country': 'de',
      },
    );

    expect(uri.path, '/custom/list.php');
    expect(uri.queryParameters['token'], 'abc');
    expect(uri.queryParameters['type'], 'm3u');
    expect(uri.queryParameters['output'], 'hls');
    expect(uri.queryParameters['country'], 'de');
  });
}
