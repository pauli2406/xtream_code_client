import 'package:test/test.dart';
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/parse_exception.dart';
import 'package:xtream_code_client/src/v2/core/parser_options.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';

void main() {
  group('ValueParser.asBool', () {
    test('parses common bool formats', () {
      final context = ParseContext();

      expect(ValueParser.asBool('1', context, r'$.a'), isTrue);
      expect(ValueParser.asBool('0', context, r'$.b'), isFalse);
      expect(ValueParser.asBool('true', context, r'$.c'), isTrue);
      expect(ValueParser.asBool('false', context, r'$.d'), isFalse);
      expect(ValueParser.asBool(1, context, r'$.e'), isTrue);
      expect(ValueParser.asBool(0, context, r'$.f'), isFalse);
      expect(ValueParser.asBool(true, context, r'$.g'), isTrue);
      expect(ValueParser.asBool(false, context, r'$.h'), isFalse);
      expect(context.warnings, isEmpty);
    });
  });

  group('ValueParser.asInt/asDouble', () {
    test('parses numeric strings and values', () {
      final context = ParseContext();

      expect(ValueParser.asInt('123', context, r'$.intString'), 123);
      expect(ValueParser.asDouble('4.5', context, r'$.doubleString'), 4.5);
      expect(ValueParser.asInt(42, context, r'$.intNum'), 42);
      expect(ValueParser.asDouble(3, context, r'$.doubleNum'), 3.0);
      expect(context.warnings, isEmpty);
    });

    test('records warning for invalid numbers', () {
      final context = ParseContext();

      expect(ValueParser.asInt('abc', context, r'$.intInvalid'), isNull);
      expect(ValueParser.asDouble('abc', context, r'$.doubleInvalid'), isNull);
      expect(context.warnings.length, 2);
    });
  });

  group('ValueParser.asDateTimeUtc', () {
    test('parses epoch seconds and milliseconds', () {
      final context = ParseContext();

      final seconds =
          ValueParser.asDateTimeUtc('1713304800', context, r'$.seconds');
      final millis =
          ValueParser.asDateTimeUtc('1713304800000', context, r'$.millis');

      expect(
        seconds,
        DateTime.fromMillisecondsSinceEpoch(1713304800 * 1000, isUtc: true),
      );
      expect(
        millis,
        DateTime.fromMillisecondsSinceEpoch(1713304800000, isUtc: true),
      );
      expect(context.warnings, isEmpty);
    });

    test('parses ISO and yyyy-MM-dd HH:mm:ss as UTC', () {
      final context = ParseContext();

      final iso =
          ValueParser.asDateTimeUtc('2024-04-16T23:00:00Z', context, r'$.iso');
      final plain =
          ValueParser.asDateTimeUtc('2024-04-16 23:00:00', context, r'$.plain');

      expect(iso, DateTime.utc(2024, 4, 16, 23));
      expect(plain, DateTime.utc(2024, 4, 16, 23));
      expect(context.warnings, isEmpty);
    });

    test('parses yyyy-MM-dd date-only value as UTC midnight', () {
      final context = ParseContext();

      final dateOnly =
          ValueParser.asDateTimeUtc('2024-04-16', context, r'$.dateOnly');

      expect(dateOnly, DateTime.utc(2024, 4, 16));
      expect(context.warnings, isEmpty);
    });

    test('returns null and warning for invalid value in lenient mode', () {
      final context = ParseContext();

      final value =
          ValueParser.asDateTimeUtc('not-a-date', context, r'$.invalid');

      expect(value, isNull);
      expect(context.warnings.length, 1);
      expect(context.warnings.first.code, 'invalid_datetime');
    });

    test('does not treat short numeric strings as epoch', () {
      final context = ParseContext();

      final value = ValueParser.asDateTimeUtc('2024', context, r'$.yearOnly');

      expect(value, isNull);
      expect(context.warnings.length, 1);
      expect(context.warnings.first.code, 'invalid_datetime');
    });

    test('throws in strict mode when parsing fails', () {
      final context = ParseContext(options: const ParserOptions.strict());

      expect(
        () => ValueParser.asDateTimeUtc('not-a-date', context, r'$.invalid'),
        throwsA(isA<ParseException>()),
      );
    });
  });

  group('ValueParser.read* map helpers', () {
    test('readers parse map field values and preserve warning paths', () {
      final context = ParseContext();
      final json = <String, dynamic>{
        'intValue': '42',
        'boolValue': 'true',
        'badDouble': 'not-a-double',
      };

      expect(ValueParser.readInt(json, 'intValue', context, r'$.root'), 42);
      expect(
          ValueParser.readBool(json, 'boolValue', context, r'$.root'), isTrue);
      expect(
        ValueParser.readDouble(json, 'badDouble', context, r'$.root'),
        isNull,
      );

      expect(context.warnings.length, 1);
      expect(context.warnings.single.code, 'invalid_double');
      expect(context.warnings.single.jsonPath, r'$.root.badDouble');
    });
  });
}
