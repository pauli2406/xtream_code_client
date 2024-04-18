import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeGeneralInformation', () {
    test('fromJson should parse json correctly', () {
      // Mock JSON with string values
      final mockJsonString = {
        'user_info': {
          'username': 'user',
          'password': 'password',
          'message': 'Panel',
          'auth': 1,
          'status': 'Active',
          'exp_date': '1736803988',
          'is_trial': '0',
          'active_cons': '0',
          'created_at': '1713375571',
          'max_connections': '1',
          'allowed_output_formats': ['m3u8', 'ts', 'rtmp'],
        },
        'server_info': {
          'xui': true,
          'version': '1.5.5',
          'revision': 2,
          'url': 'iptv.some.com',
          'port': '1111',
          'https_port': '9999',
          'server_protocol': 'http',
          'rtmp_port': '8882',
          'timestamp_now': 1713375571,
          'time_now': '2024-04-17 19:39:31',
          'timezone': 'Europe/Berlin',
        },
      };

      final item = XTremeCodeGeneralInformation.fromJson(mockJsonString);
      expect(item.userInfo, isNotNull);
      expect(item.serverInfo, isNotNull);
    });
  });
}
