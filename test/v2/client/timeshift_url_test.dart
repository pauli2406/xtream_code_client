import 'package:test/test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  test('builds timeshift URL from connection credentials', () {
    final client = XtreamClient(
      url: 'https://example.com',
      username: 'alice',
      password: 'secret',
    );

    final result = client.timeshiftUrl(
      streamId: 55,
      start: DateTime.utc(2026, 2, 11, 14, 5),
      duration: const Duration(minutes: 95),
    );

    final uri = Uri.parse(result);
    expect(
      uri.path,
      '/timeshift/alice/secret/95/2026-02-11:14-05/55.ts',
    );
  });

  test('supports output format override and minimum duration of one minute',
      () {
    final client = XtreamClient(
      url: 'https://example.com',
      username: 'alice',
      password: 'secret',
    );

    final result = client.timeshiftUrl(
      streamId: 55,
      start: DateTime.utc(2026, 2, 11, 14, 5),
      duration: Duration.zero,
      outputFormat: 'm3u8',
    );

    final uri = Uri.parse(result);
    expect(
      uri.path,
      '/timeshift/alice/secret/1/2026-02-11:14-05/55.m3u8',
    );
  });

  test('throws when credentials cannot be inferred for timeshift URL', () {
    final client = XtreamClient.fromResolvedUrls(
      baseUrl: 'https://example.com/player_api.php?username=u&password=p',
      streamUrl: 'https://example.com/live',
      movieUrl: 'https://example.com/movie',
      seriesUrl: 'https://example.com/series',
    );

    expect(
      () => client.timeshiftUrl(
        streamId: 77,
        start: DateTime.utc(2026, 1, 1, 10, 0),
        duration: const Duration(minutes: 30),
      ),
      throwsA(isA<RequestException>()),
    );
  });
}
