import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeUserInfo', () {
    // Base JSON map used for creating fresh maps per test
    Map<String, dynamic> createMockJsonString() => {
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
    };
    test('some values are strings', () {
      final mockJsonString = createMockJsonString();
      final item = XTremeCodeUserInfo.fromJson(mockJsonString);
      expect(item, isNotNull);
      expect(item.username, 'user');
      expect(item.password, 'password');
      expect(item.message, 'Panel');
      expect(item.auth, true);
      expect(item.status, 'Active');
      expect(item.expDate, dateTimeFromEpochSeconds(1736803988));
      expect(item.isTrial, false);
      expect(item.activeCons, 0);
      expect(item.createdAt, dateTimeFromEpochSeconds(1713375571));
      expect(item.maxConnections, 1);
      expect(item.allowedOutputFormats, ['m3u8', 'ts', 'rtmp']);
    });

    test('some values are numbers', () {
      final mockJsonString = createMockJsonString();
      mockJsonString['exp_date'] = 1736803988;
      mockJsonString['is_trial'] = 0;
      mockJsonString['active_cons'] = 0;
      mockJsonString['created_at'] = 1713375571;
      mockJsonString['max_connections'] = 1;

      final item = XTremeCodeUserInfo.fromJson(mockJsonString);
      expect(item, isNotNull);
      expect(item.username, 'user');
      expect(item.password, 'password');
      expect(item.message, 'Panel');
      expect(item.auth, true);
      expect(item.status, 'Active');
      expect(item.expDate, dateTimeFromEpochSeconds(1736803988));
      expect(item.isTrial, false);
      expect(item.activeCons, 0);
      expect(item.createdAt, dateTimeFromEpochSeconds(1713375571));
      expect(item.maxConnections, 1);
      expect(item.allowedOutputFormats, ['m3u8', 'ts', 'rtmp']);
    });

    test('some values are boolean', () {
      final mockJsonString = createMockJsonString();
      mockJsonString['is_trial'] = false;
      mockJsonString['auth'] = true;

      final item = XTremeCodeUserInfo.fromJson(mockJsonString);
      expect(item, isNotNull);
      expect(item.username, 'user');
      expect(item.password, 'password');
      expect(item.message, 'Panel');
      expect(item.auth, true);
      expect(item.status, 'Active');
      expect(item.expDate, dateTimeFromEpochSeconds(1736803988));
      expect(item.isTrial, false);
      expect(item.activeCons, 0);
      expect(item.createdAt, dateTimeFromEpochSeconds(1713375571));
      expect(item.maxConnections, 1);
      expect(item.allowedOutputFormats, ['m3u8', 'ts', 'rtmp']);
    });

    test('list can contain nulls', () {
      final mockJsonString = createMockJsonString();
      mockJsonString['allowed_output_formats'] = ['m3u8', null, 'ts'];

      final item = XTremeCodeUserInfo.fromJson(mockJsonString);
      expect(item.allowedOutputFormats, ['m3u8', 'ts']);
    });
  });
}
