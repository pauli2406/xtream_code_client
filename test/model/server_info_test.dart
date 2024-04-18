import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeServerInfo', () {
    final mockJsonString = {
      'xui': true,
      'version': '1.5.5',
      'revision': 2,
      'url': 'iptv.some.com',
      'port': '1111',
      'https_port': '9999',
      'server_protocol': 'http',
      'rtmp_port': '8888',
      'timestamp_now': '1713375571',
      'time_now': '2024-04-17 19:39:31',
      'timezone': 'Europe/Berlin',
    };

    test('fromJson should parse json correctly with string values', () {
      final item = XTremeCodeServerInfo.fromJson(mockJsonString);
      expect(item.xui, true);
      expect(item.version, '1.5.5');
      expect(item.revision, 2);
      expect(item.url, 'iptv.some.com');
      expect(item.port, 1111);
      expect(item.httpsPort, 9999);
      expect(item.serverProtocol, 'http');
      expect(item.rtmpPort, 8888);
      expect(item.timestampNow, dateTimeFromEpochSeconds(1713375571));
      expect(item.timeNow, dateTimeFromString('2024-04-17 19:39:31'));
      expect(item.timezone, 'Europe/Berlin');
    });

    test('fromJson should parse json correctly with integer values', () {
      final mockJsonString2 = {
        ...mockJsonString,
        'xui': 1,
        'revision': '2',
        'port': 1111,
        'https_port': 9999,
        'rtmp_port': 8888,
        'timestamp_now': 1713375571,
      };

      final item = XTremeCodeServerInfo.fromJson(mockJsonString2);
      expect(item.xui, true);
      expect(item.version, '1.5.5');
      expect(item.revision, 2);
      expect(item.url, 'iptv.some.com');
      expect(item.port, 1111);
      expect(item.httpsPort, 9999);
      expect(item.serverProtocol, 'http');
      expect(item.rtmpPort, 8888);
      expect(item.timestampNow, dateTimeFromEpochSeconds(1713375571));
      expect(item.timeNow, dateTimeFromString('2024-04-17 19:39:31'));
      expect(item.timezone, 'Europe/Berlin');
    });

    test('fromJson should parse json correctly with mixed values', () {
      final mockJsonString3 = {
        ...mockJsonString,
        'xui': '1',
      };

      final item = XTremeCodeServerInfo.fromJson(mockJsonString3);
      expect(item.xui, true);
      expect(item.version, '1.5.5');
      expect(item.revision, 2);
      expect(item.url, 'iptv.some.com');
      expect(item.port, 1111);
      expect(item.httpsPort, 9999);
      expect(item.serverProtocol, 'http');
      expect(item.rtmpPort, 8888);
      expect(item.timestampNow, dateTimeFromEpochSeconds(1713375571));
      expect(item.timeNow, dateTimeFromString('2024-04-17 19:39:31'));
      expect(item.timezone, 'Europe/Berlin');
    });
  });
}
