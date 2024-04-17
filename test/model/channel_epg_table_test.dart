import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  final mockJsonString = {
    'epg_listings': [
      {
        'id': '67843793',
        'epg_id': '35',
        'title': 'VGFnZXNzY2hhdQ==',
        'lang': '',
        'start': '2024-04-09 01:33:00',
        'end': '2024-04-09 01:35:00',
        'description': 'RGllIE5hY2hyaWNodGVuIGRlciBBUkQ=',
        'channel_id': '79ce20574b68a61835dd860a6b149c9d',
        'start_timestamp': '1712619180',
        'stop_timestamp': '1712619300',
        'now_playing': '0',
        'has_archive': '0',
      },
    ],
  };

  group('XTremeCodeChannelEpgTable', () {
    test('fromJson should parse json correctly with string values', () {
      final table = XTremeCodeChannelEpgTable.fromJson(mockJsonString);
      final listing = table.epgListings[0];
      expect(listing.id, 67843793);
      expect(listing.epgId, 35);
      expect(listing.title, 'VGFnZXNzY2hhdQ==');
      expect(listing.lang, '');
      expect(listing.start, DateTime.parse('2024-04-09 01:33:00'));
      expect(listing.end, DateTime.parse('2024-04-09 01:35:00'));
      expect(listing.description, 'RGllIE5hY2hyaWNodGVuIGRlciBBUkQ=');
      expect(listing.channelId, '79ce20574b68a61835dd860a6b149c9d');
      expect(listing.startTimestamp, dateTimeFromEpochSeconds('1712619180'));
      expect(listing.stopTimestamp, dateTimeFromEpochSeconds('1712619300'));
      expect(listing.nowPlaying, false);
      expect(listing.hasArchive, false);
    });

    test('fromJson should parse json correctly with integer values', () {
      final mockJsonInt = {
        'epg_listings': [
          {
            'id': 67843793,
            'epg_id': 35,
            'title': 'VGFnZXNzY2hhdQ==',
            'lang': '',
            'start': '2024-04-09 01:33:00',
            'end': '2024-04-09 01:35:00',
            'description': 'RGllIE5hY2hyaWNodGVuIGRlciBBUkQ=',
            'channel_id': '79ce20574b68a61835dd860a6b149c9d',
            'start_timestamp': '1712619180',
            'stop_timestamp': '1712619300',
            'now_playing': 0,
            'has_archive': 0,
          },
        ],
      };

      final table = XTremeCodeChannelEpgTable.fromJson(mockJsonInt);
      final listing = table.epgListings[0];
      expect(listing.id, 67843793);
      expect(listing.epgId, 35);
      expect(listing.title, 'VGFnZXNzY2hhdQ==');
      expect(listing.lang, '');
      expect(listing.start, DateTime.parse('2024-04-09 01:33:00'));
      expect(listing.end, DateTime.parse('2024-04-09 01:35:00'));
      expect(listing.description, 'RGllIE5hY2hyaWNodGVuIGRlciBBUkQ=');
      expect(listing.channelId, '79ce20574b68a61835dd860a6b149c9d');
      expect(listing.startTimestamp, dateTimeFromEpochSeconds('1712619180'));
      expect(listing.stopTimestamp, dateTimeFromEpochSeconds('1712619300'));
      expect(listing.nowPlaying, false);
      expect(listing.hasArchive, false);
    });
  });
}
