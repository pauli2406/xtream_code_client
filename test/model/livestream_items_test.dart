import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeVodItem', () {
    // Mock JSON with string values
    final mockJsonString = {
      'num': '6',
      'name': 'Some Channel',
      'stream_type': 'live',
      'stream_id': '2',
      'stream_icon': 'https://someurl.com/icon.jpg',
      'epg_channel_id': 'Some EPG ID',
      'added': '1570557158',
      'custom_sid': '',
      'tv_archive': '0',
      'direct_source': '',
      'tv_archive_duration': '0',
      'category_id': '1',
      'category_ids': [1],
      'thumbnail': '',
    };
    test('some values are strings', () {
      final item = XTremeCodeLiveStreamItem.fromJson(mockJsonString);
      expect(item.num, 6);
      expect(item.name, 'Some Channel');
      expect(item.streamType, 'live');
      expect(item.streamId, 2);
      expect(item.streamIcon, 'https://someurl.com/icon.jpg');
      expect(item.epgChannelId, 'Some EPG ID');
      expect(item.added, DateTime.fromMillisecondsSinceEpoch(1570557158 * 1000));
      expect(item.customSid, null);
      expect(item.tvArchive, 0);
      expect(item.directSource, '');
      expect(item.tvArchiveDuration, 0);
      expect(item.categoryId, 1);
      expect(item.categoryIds, [1]);
      expect(item.thumbnail, '');
    });

    test('some values are numbers', () {
      final mockJsonString2 = {
        ...mockJsonString,
        'num': 6,
        'stream_id': 2,
        'added': 1570557158,
        'tv_archive': 0,
        'tv_archive_duration': 0,
        'category_id': 1,
      };
      final item = XTremeCodeLiveStreamItem.fromJson(mockJsonString2);
      expect(item.num, 6);
      expect(item.streamId, 2);
      expect(item.added, DateTime.fromMillisecondsSinceEpoch(1570557158 * 1000));
      expect(item.tvArchive, 0);
      expect(item.tvArchiveDuration, 0);
      expect(item.categoryId, 1);
    });
  });
}
