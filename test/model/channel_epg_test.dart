import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  final json = {
    'epg_listings': [
      {
        'id': '69235874',
        'epg_id': '39',
        'title': 'cGhvZW5peCBkZXIgdGFn',
        'lang': '',
        'start': '2024-04-16 23:00:00',
        'end': '1713304800',
        'description':
            'RGllIFNlbmR1bmcgZmFzc3QgZGllIHdpY2h0aWdlbiBFcmVpZ25pc3NlLCBUaGVtZW4gdW5kIERpc2t1c3Npb25lbiBkZXMgVGFnZXMgenVzYW1tZW4uIE5lYmVuIGRpZXNlciBUaGVtYXRpc2llcnVuZyBiZWxldWNodGV0IGRpZSBTZW5kdW5nIGRpZSBha3R1ZWxsZW4gRGViYXR0ZW4gdW5kIFRoZW1lbiBtaXQgZWluZXIgdW1mYW5ncmVpY2hlcmVuIHVuZCBoaW50ZXJncsO8bmRpZ2VyZW4gQXVzZWluYW5kZXJzZXR6dW5nLg==',
        'channel_id': 'DE: Phoenix',
        'start_timestamp': '1713301200',
        'stop_timestamp': '1713304800',
        'stop': '2024-04-17 00:00:00'
      },
      {
        'id': 69235874,
        'epg_id': 39,
        'title': 'cGhvZW5peCBkZXIgdGFn',
        'lang': '',
        'start': '2024-04-16 23:00:00',
        'end': 1713304800,
        'description':
            'RGllIFNlbmR1bmcgZmFzc3QgZGllIHdpY2h0aWdlbiBFcmVpZ25pc3NlLCBUaGVtZW4gdW5kIERpc2t1c3Npb25lbiBkZXMgVGFnZXMgenVzYW1tZW4uIE5lYmVuIGRpZXNlciBUaGVtYXRpc2llcnVuZyBiZWxldWNodGV0IGRpZSBTZW5kdW5nIGRpZSBha3R1ZWxsZW4gRGViYXR0ZW4gdW5kIFRoZW1lbiBtaXQgZWluZXIgdW1mYW5ncmVpY2hlcmVuIHVuZCBoaW50ZXJncsO8bmRpZ2VyZW4gQXVzZWluYW5kZXJzZXR6dW5nLg==',
        'channel_id': 'DE: Phoenix',
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
      expect(epg.epgListings[0].title, 'cGhvZW5peCBkZXIgdGFn');
      expect(epg.epgListings[0].lang, '');
      expect(epg.epgListings[0].start, DateTime.parse('2024-04-16 23:00:00'));
      expect(epg.epgListings[0].end, dateTimeFromEpochSeconds('1713304800'));
      expect(epg.epgListings[0].description,
          'RGllIFNlbmR1bmcgZmFzc3QgZGllIHdpY2h0aWdlbiBFcmVpZ25pc3NlLCBUaGVtZW4gdW5kIERpc2t1c3Npb25lbiBkZXMgVGFnZXMgenVzYW1tZW4uIE5lYmVuIGRpZXNlciBUaGVtYXRpc2llcnVuZyBiZWxldWNodGV0IGRpZSBTZW5kdW5nIGRpZSBha3R1ZWxsZW4gRGViYXR0ZW4gdW5kIFRoZW1lbiBtaXQgZWluZXIgdW1mYW5ncmVpY2hlcmVuIHVuZCBoaW50ZXJncsO8bmRpZ2VyZW4gQXVzZWluYW5kZXJzZXR6dW5nLg==');
      expect(epg.epgListings[0].channelId, 'DE: Phoenix');
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
      expect(epg.epgListings[1].title, 'cGhvZW5peCBkZXIgdGFn');
      expect(epg.epgListings[1].lang, '');
      expect(epg.epgListings[1].start, DateTime.parse('2024-04-16 23:00:00'));
      expect(epg.epgListings[1].end, dateTimeFromEpochSeconds('1713304800'));
      expect(epg.epgListings[1].description,
          'RGllIFNlbmR1bmcgZmFzc3QgZGllIHdpY2h0aWdlbiBFcmVpZ25pc3NlLCBUaGVtZW4gdW5kIERpc2t1c3Npb25lbiBkZXMgVGFnZXMgenVzYW1tZW4uIE5lYmVuIGRpZXNlciBUaGVtYXRpc2llcnVuZyBiZWxldWNodGV0IGRpZSBTZW5kdW5nIGRpZSBha3R1ZWxsZW4gRGViYXR0ZW4gdW5kIFRoZW1lbiBtaXQgZWluZXIgdW1mYW5ncmVpY2hlcmVuIHVuZCBoaW50ZXJncsO8bmRpZ2VyZW4gQXVzZWluYW5kZXJzZXR6dW5nLg==');
      expect(epg.epgListings[1].channelId, 'DE: Phoenix');
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
