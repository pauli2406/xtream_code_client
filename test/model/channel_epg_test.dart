import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  final json = {
    'epg_listings': [
      {
        'id': '69235874',
        'epg_id': '39',
        'title': 'Some Title',
        'lang': '',
        'start': '2024-04-16 23:00:00',
        'end': '1713304800',
        'description': 'Some Description',
        'channel_id': 'Some ID',
        'start_timestamp': '1713301200',
        'stop_timestamp': '1713304800',
        'stop': '2024-04-17 00:00:00',
      },
      {
        'id': 69235874,
        'epg_id': 39,
        'title': 'Some Title',
        'lang': '',
        'start': '2024-04-16 23:00:00',
        'end': 1713304800,
        'description': 'Some Description',
        'channel_id': 'Some ID',
        'start_timestamp': 1713301200,
        'stop_timestamp': 1713304800,
        'stop': '2024-04-17 00:00:00',
      },
    ],
  };

  group('XTremeCodeChannelEpg', () {
    test('should parse from JSON correctly - Case 1', () {
      final epg = XTremeCodeChannelEpg.fromJson(json);

      expect(epg.epgListings!.length, 2);
      final item = epg.epgListings![0];
      // Check first listing
      expect(item.id, 69235874);
      expect(item.epgId, 39);
      expect(item.title, 'Some Title');
      expect(item.lang, '');
      expect(item.start, DateTime.parse('2024-04-16 23:00:00'));
      expect(item.end, dateTimeFromEpochSeconds('1713304800'));
      expect(item.description, 'Some Description');
      expect(item.channelId, 'Some ID');
      expect(
        item.startTimestamp,
        dateTimeFromEpochSeconds('1713301200'),
      );
      expect(
        item.stopTimestamp,
        dateTimeFromEpochSeconds('1713304800'),
      );
      expect(item.stop, DateTime.parse('2024-04-17 00:00:00'));
    });

    test('should parse from JSON correctly - Case 2', () {
      final epg = XTremeCodeChannelEpg.fromJson(json);

      expect(epg.epgListings!.length, 2);
      final item = epg.epgListings![0];

      // Check second listing
      expect(item.id, 69235874);
      expect(item.epgId, 39);
      expect(item.title, 'Some Title');
      expect(item.lang, '');
      expect(item.start, DateTime.parse('2024-04-16 23:00:00'));
      expect(item.end, dateTimeFromEpochSeconds('1713304800'));
      expect(item.description, 'Some Description');
      expect(item.channelId, 'Some ID');
      expect(
        item.startTimestamp,
        dateTimeFromEpochSeconds('1713301200'),
      );
      expect(
        item.stopTimestamp,
        dateTimeFromEpochSeconds('1713304800'),
      );
      expect(item.stop, DateTime.parse('2024-04-17 00:00:00'));
    });
  });
}
