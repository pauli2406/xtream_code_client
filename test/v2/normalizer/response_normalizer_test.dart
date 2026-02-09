import 'package:test/test.dart';
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/normalizer/response_normalizer.dart';

void main() {
  group('ResponseNormalizer', () {
    test('normalizes map values to list of objects', () {
      final context = ParseContext();
      final payload = <String, dynamic>{
        '1': <String, dynamic>{'id': '1'},
        '2': <String, dynamic>{'id': '2'},
      };

      final result =
          ResponseNormalizer.expectObjectList(payload, context, r'$');

      expect(result.length, 2);
      expect(
          context.warnings.any((w) => w.code == 'map_values_list_normalized'),
          isTrue);
    });

    test('returns empty list for unexpected scalar payload', () {
      final context = ParseContext();

      final result = ResponseNormalizer.expectObjectList('oops', context, r'$');

      expect(result, isEmpty);
      expect(context.warnings.any((w) => w.code == 'invalid_list'), isTrue);
    });

    test(
        'decoding invalid json emits warning and does not throw in lenient mode',
        () {
      final context = ParseContext();

      final decoded =
          ResponseNormalizer.decodeJsonBody('{broken', context, r'$');

      expect(decoded, isNull);
      expect(context.warnings.any((w) => w.code == 'invalid_json'), isTrue);
    });
  });
}
