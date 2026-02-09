import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('Legacy compatibility wrappers', () {
    test('legacy client methods remain callable and return legacy model types',
        () async {
      const baseUrl =
          'https://example.com/player_api.php?username=user&password=pass';
      final mock = MockClient((request) async {
        final action = request.url.queryParameters['action'];

        if (action == null) {
          return Response(
            jsonEncode(<String, dynamic>{
              'user_info': <String, dynamic>{
                'username': 'user',
                'password': 'pass',
                'auth': '1',
                'status': 'Active',
              },
              'server_info': <String, dynamic>{
                'xui': '1',
                'url': 'example.com',
              },
            }),
            200,
          );
        }

        if (action == 'get_series') {
          return Response(
            jsonEncode(<Map<String, dynamic>>[
              <String, dynamic>{
                'num': '1',
                'series_id': '42',
                'name': 'Series',
                'release_date': '2024-01-01',
              },
            ]),
            200,
          );
        }

        if (action == 'get_short_epg') {
          return Response(
            jsonEncode(<String, dynamic>{
              'epg_listings': <Map<String, dynamic>>[
                <String, dynamic>{
                  'id': '10',
                  'stop': '2024-04-17 00:00:00',
                },
              ],
            }),
            200,
          );
        }

        if (action == 'get_vod_streams') {
          return Response(
            jsonEncode(<Map<String, dynamic>>[
              <String, dynamic>{
                'stream_id': '99',
                'name': 'Movie',
              },
            ]),
            200,
          );
        }

        if (action == 'get_vod_info') {
          return Response(
            jsonEncode(<String, dynamic>{
              'info': <String, dynamic>{
                'release_date': '2024-01-12',
                'releasedate': '2024-01-12',
              },
              'movie_data': <String, dynamic>{
                'stream_id': '99',
                'container_extension': 'mkv',
              },
            }),
            200,
          );
        }

        return Response(jsonEncode(<String, dynamic>{}), 200);
      });

      final legacyClient = XtreamCodeClient(
        baseUrl,
        'https://example.com/user/pass',
        'https://example.com/movie/user/pass',
        'https://example.com/series/user/pass',
        mock,
      );

      final general = await legacyClient.serverInformation();
      expect(general, isA<XTremeCodeGeneralInformation>());
      expect(general.userInfo.username, 'user');

      final series = await legacyClient.seriesItems();
      expect(series.single, isA<XTremeCodeSeriesItem>());
      expect(series.single.releaseDate, '2024-01-01');

      final epg = await legacyClient.channelEpgViaStreamId(10, null);
      expect(epg, isA<XTremeCodeChannelEpg>());
      expect(epg.epgListings?.single.end, DateTime.utc(2024, 4, 17));

      final vods = await legacyClient.vodItems();
      final vodInfo = await legacyClient.vodInfo(vods.single);
      expect(vodInfo, isA<XTremeCodeVodInfo>());
      expect(vodInfo.info.releaseDate, DateTime.utc(2024, 1, 12));
      expect(vodInfo.info.releasedate, DateTime.utc(2024, 1, 12));
    });

    test('epg wraps async failures in XTreamCodeClientException', () async {
      const baseUrl =
          'https://example.com/player_api.php?username=user&password=pass';
      final mock = MockClient((request) async {
        if (request.url.path.endsWith('xmltv.php')) {
          return Response('server error', 500);
        }
        return Response('{}', 200);
      });

      final legacyClient = XtreamCodeClient(
        baseUrl,
        'https://example.com/user/pass',
        'https://example.com/movie/user/pass',
        'https://example.com/series/user/pass',
        mock,
      );

      await expectLater(
        legacyClient.epg(),
        throwsA(isA<XTreamCodeClientException>()),
      );
    });

    test('legacy wrapper does not leak credentials in wrapped failures',
        () async {
      const baseUrl =
          'https://example.com/player_api.php?username=legacy-user&password=legacy-pass';
      final mock = MockClient((request) async {
        return Response('server error', 500);
      });

      final legacyClient = XtreamCodeClient(
        baseUrl,
        'https://example.com/legacy-user/legacy-pass',
        'https://example.com/movie/legacy-user/legacy-pass',
        'https://example.com/series/legacy-user/legacy-pass',
        mock,
      );

      try {
        await legacyClient.serverInformation();
        fail('Expected XTreamCodeClientException');
      } catch (error) {
        expect(error, isA<XTreamCodeClientException>());
        final cause = (error as XTreamCodeClientException).cause;

        expect(cause, contains('status code 500'));
        expect(cause, isNot(contains('legacy-user')));
        expect(cause, isNot(contains('legacy-pass')));
      }
    });
  });
}
