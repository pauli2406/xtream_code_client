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
        'stop': '2024-04-17 00:00:00'
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
        'stop': '2024-04-17 00:00:00'
      },
    ],
  };

  group('XTremeCodeChannelEpg', () {
    test('should parse from JSON correctly - Case 1', () {
      final epg = XTremeCodeChannelEpg.fromJson(json);

      expect(epg.epgListings.length, 2);

      // Check first listing
      expect(epg.epgListings[0].id, 69235874);
      expect(epg.epgListings[0].epgId, 39);
      expect(epg.epgListings[0].title, 'Some Title');
      expect(epg.epgListings[0].lang, '');
      expect(epg.epgListings[0].start, DateTime.parse('2024-04-16 23:00:00'));
      expect(epg.epgListings[0].end, dateTimeFromEpochSeconds('1713304800'));
      expect(epg.epgListings[0].description, 'Some Description');
      expect(epg.epgListings[0].channelId, 'Some ID');
      expect(
        epg.epgListings[0].startTimestamp,
        dateTimeFromEpochSeconds('1713301200'),
      );
      expect(
        epg.epgListings[0].stopTimestamp,
        dateTimeFromEpochSeconds('1713304800'),
      );
      expect(epg.epgListings[0].stop, DateTime.parse('2024-04-17 00:00:00'));
    });

    test('should parse from JSON correctly - Case 2', () {
      final epg = XTremeCodeChannelEpg.fromJson(json);

      expect(epg.epgListings.length, 2);

      // Check second listing
      expect(epg.epgListings[1].id, 69235874);
      expect(epg.epgListings[1].epgId, 39);
      expect(epg.epgListings[1].title, 'Some Title');
      expect(epg.epgListings[1].lang, '');
      expect(epg.epgListings[1].start, DateTime.parse('2024-04-16 23:00:00'));
      expect(epg.epgListings[1].end, dateTimeFromEpochSeconds('1713304800'));
      expect(epg.epgListings[1].description, 'Some Description');
      expect(epg.epgListings[1].channelId, 'Some ID');
      expect(
        epg.epgListings[1].startTimestamp,
        dateTimeFromEpochSeconds('1713301200'),
      );
      expect(
        epg.epgListings[1].stopTimestamp,
        dateTimeFromEpochSeconds('1713304800'),
      );
      expect(epg.epgListings[1].stop, DateTime.parse('2024-04-17 00:00:00'));
    });
  });
}
