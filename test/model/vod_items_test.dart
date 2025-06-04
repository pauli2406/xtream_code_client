import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeVodItem', () {
    // Mock JSON with string values
    final mockJsonString = {
      'stream_id': '1234',
      'num': '2',
      'name': 'Some Vod',
      'title': 'Vod Title',
      'year': '2024',
      'stream_type': 'movie',
      'stream_icon': 'https://someurl.com/icon.jpg',
      'rating': '0.2',
      'rating_5based': '1.5',
      'added': '1705390203',
      'category_id': '295',
      'category_ids': [295, 224],
      'container_extension': 'mkv',
      'custom_sid': '',
      'direct_source': '',
    };
    test('some values are strings', () {
      final item = XTremeCodeVodItem.fromJson(mockJsonString);
      expect(item, isNotNull);
      expect(item.streamId, 1234);
      expect(item.num, 2);
      expect(item.name, 'Some Vod');
      expect(item.title, 'Vod Title');
      expect(item.year, '2024');
      expect(item.streamType, 'movie');
      expect(item.streamIcon, 'https://someurl.com/icon.jpg');
      expect(item.rating, 0.2);
      expect(item.rating5based, 1.5);
      expect(item.added, dateTimeFromEpochSeconds(1705390203));
      expect(item.categoryId, 295);
      expect(item.categoryIds, [295, 224]);
      expect(item.containerExtension, 'mkv');
      expect(item.customSid, '');
      expect(item.directSource, '');
    });

    test('some values are numbers', () {
      final mockJsonString2 = {
        ...mockJsonString,
        'stream_id': 1234,
        'num': 2,
        'rating': 0.2,
        'rating_5based': 1.5,
        'added': 1705390203,
        'category_id': 295,
      };
      final item = XTremeCodeVodItem.fromJson(mockJsonString2);
      expect(item, isNotNull);
      expect(item.streamId, 1234);
      expect(item.num, 2);
      expect(item.rating, 0.2);
      expect(item.rating5based, 1.5);
      expect(item.added, dateTimeFromEpochSeconds(1705390203));
      expect(item.categoryId, 295);
    });

    test('list can contain nulls', () {
      final jsonWithNull = {
        ...mockJsonString,
        'category_ids': [295, null],
      };

      final item = XTremeCodeVodItem.fromJson(jsonWithNull);
      expect(item.categoryIds, [295]);
    });
  });
}
