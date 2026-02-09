import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  test('RequestException is catchable from public package export', () async {
    final mock = MockClient((request) async => Response('error', 500));
    final client = XtreamClient(
      url: 'https://example.com',
      username: 'user',
      password: 'pass',
      httpClient: mock,
    );

    try {
      await client.liveStreamCategoriesData();
      fail('Expected RequestException');
    } on RequestException catch (error) {
      expect(error.message, contains('status code 500'));
    }
  });

  test('ParseException is catchable from public package export', () {
    final context = ParseContext(options: const ParserOptions.strict());

    expect(
      () => ValueParser.asDateTimeUtc('not-a-date', context, r'$.invalid'),
      throwsA(isA<ParseException>()),
    );
  });
}
