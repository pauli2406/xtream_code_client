import 'package:test/test.dart';
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/mapper/epg_mapper.dart';
import 'package:xtream_code_client/src/v2/mapper/series_mapper.dart';

void main() {
  group('Alias resolution', () {
    test('releaseDate uses configured alias priority and warns on conflicts',
        () {
      final context = ParseContext();
      final json = <String, dynamic>{
        'release_date': '2020-01-01',
        'releaseDate': '2021-01-01',
        'releasedate': '2022-01-01',
      };

      final item = SeriesMapper.itemFromMap(json, context, r'$.series');

      expect(item.releaseDate, DateTime.utc(2020, 1, 1));
      expect(
          context.warnings.where((w) => w.code == 'alias_conflict').length, 2);
    });

    test('epg end/stop are harmonized with fallbacks', () {
      final context = ParseContext();
      final root = <String, dynamic>{
        'epg_listings': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': '1',
            'end': '1713304800',
            'stop': '2024-04-17 00:00:00',
            'stop_timestamp': '1713304800',
          },
          <String, dynamic>{
            'id': '2',
            'stop': '2024-04-18 00:00:00',
            'stop_timestamp': '1713391200',
          },
        ],
      };

      final epg = EpgMapper.channelEpgFromMap(root, context, r'$');

      expect(
        epg.epgListings?.first.end,
        DateTime.fromMillisecondsSinceEpoch(1713304800 * 1000, isUtc: true),
      );
      expect(epg.epgListings?.first.stop, DateTime.utc(2024, 4, 17));
      expect(epg.epgListings?.last.end, DateTime.utc(2024, 4, 18));
      expect(epg.epgListings?.last.stop, DateTime.utc(2024, 4, 18));
      expect(
        context.warnings.where((w) => w.code == 'alias_conflict').length,
        2,
      );
      expect(
        context.warnings
            .where((w) => w.code == 'alias_conflict')
            .any((w) => w.jsonPath.contains('.stop.end')),
        isFalse,
      );
    });

    test('epg end/stop conflict emits one warning per listing', () {
      final context = ParseContext();
      final root = <String, dynamic>{
        'epg_listings': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': '1',
            'end': '1713304800',
            'stop': '2024-04-17 00:00:00',
            'stop_timestamp': '1713304800',
          },
        ],
      };

      final epg = EpgMapper.channelEpgFromMap(root, context, r'$');

      expect(
        epg.epgListings?.single.end,
        DateTime.fromMillisecondsSinceEpoch(1713304800 * 1000, isUtc: true),
      );
      expect(epg.epgListings?.single.stop, DateTime.utc(2024, 4, 17));
      expect(
        context.warnings.where((w) => w.code == 'alias_conflict').length,
        1,
      );
    });
  });
}
