import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  test('vodInfo throws RequestException when vod.streamId is null', () async {
    var calls = 0;
    final mock = MockClient((request) async {
      calls++;
      return Response('{}', 200);
    });

    final client = XtreamClient(
      url: 'https://example.com',
      username: 'user',
      password: 'pass',
      httpClient: mock,
    );

    expect(
      () => client.vodInfo(const VodItem(streamId: null)),
      throwsA(
        isA<RequestException>().having(
          (error) => error.message,
          'message',
          contains('vodInfo'),
        ),
      ),
    );

    expect(calls, 0);
  });

  test('seriesInfo throws RequestException when series.seriesId is null',
      () async {
    var calls = 0;
    final mock = MockClient((request) async {
      calls++;
      return Response('{}', 200);
    });

    final client = XtreamClient(
      url: 'https://example.com',
      username: 'user',
      password: 'pass',
      httpClient: mock,
    );

    expect(
      () => client.seriesInfo(const SeriesItem(seriesId: null)),
      throwsA(
        isA<RequestException>().having(
          (error) => error.message,
          'message',
          contains('seriesInfo'),
        ),
      ),
    );

    expect(calls, 0);
  });
}
