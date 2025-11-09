/// Parser for converting dynamic values to [DateTime].
// ignore: one_member_abstracts
// This abstract class is necessary for the factory pattern and type system
// used in ParserConfig to store different parser implementations.
abstract class DateParser {
  /// Creates a parser for dates.
  const DateParser();

  /// Parses a dynamic value to a [DateTime].
  /// Returns null if parsing fails or value is null.
  DateTime? parse(dynamic value);

  /// Creates a parser that only accepts epoch seconds (int or string).
  factory DateParser.epochSeconds() => const _EpochSecondsParser();

  /// Creates a parser that only accepts ISO 8601 strings.
  factory DateParser.iso8601() => const _Iso8601Parser();

  /// Creates a parser that automatically detects the format.
  factory DateParser.autoDetect() => const SmartDateParser();

  /// Creates a custom parser with a provided function.
  factory DateParser.custom(DateTime? Function(dynamic) parser) =>
      _CustomDateParser(parser);
}

/// Parser that only accepts epoch seconds.
class _EpochSecondsParser extends DateParser {
  const _EpochSecondsParser();

  @override
  DateTime? parse(dynamic value) {
    if (value == null) return null;

    int? epochSeconds;

    if (value is String) {
      if (value.isEmpty) return null;
      epochSeconds = int.tryParse(value);
    } else if (value is num) {
      epochSeconds = value.toInt();
    }

    if (epochSeconds == null) return null;

    // Check if it's seconds (10 digits) or milliseconds (13 digits)
    if (epochSeconds < 10000000000) {
      // Seconds
      return DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
    } else {
      // Milliseconds
      return DateTime.fromMillisecondsSinceEpoch(epochSeconds);
    }
  }
}

/// Parser that only accepts ISO 8601 strings.
class _Iso8601Parser extends DateParser {
  const _Iso8601Parser();

  @override
  DateTime? parse(dynamic value) {
    if (value == null || value is! String || value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value);
  }
}

/// Smart parser that automatically detects the format.
class SmartDateParser extends DateParser {
  /// Creates a smart parser that automatically detects the format.
  const SmartDateParser();

  @override
  DateTime? parse(dynamic value) {
    if (value == null) return null;

    // Strategy 1: Already a DateTime (shouldn't happen, but safe)
    if (value is DateTime) return value;

    // Strategy 2: ISO 8601 string formats
    if (value is String) {
      // Standard: "2024-04-09T01:35:00Z"
      var parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed;

      // Weird format: "2024-04-09 01:35:00"
      parsed = DateTime.tryParse(value.replaceAll(' ', 'T'));
      if (parsed != null) return parsed;

      // Try with timezone offset: "2024-04-09 01:35:00 +0200"
      final spaceIndex = value.lastIndexOf(' ');
      if (spaceIndex > 0) {
        final datePart = value.substring(0, spaceIndex).replaceAll(' ', 'T');
        final tzPart = value.substring(spaceIndex + 1);
        parsed = DateTime.tryParse('$datePart$tzPart');
        if (parsed != null) return parsed;
      }

      // Strategy 3: Epoch seconds as string
      final epoch = int.tryParse(value);
      if (epoch != null) {
        // Check if it's seconds (10 digits) or milliseconds (13 digits)
        if (epoch < 10000000000) {
          // Seconds
          return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
        } else {
          // Milliseconds
          return DateTime.fromMillisecondsSinceEpoch(epoch);
        }
      }
    }

    // Strategy 4: Epoch seconds as number
    if (value is num) {
      final epoch = value.toInt();
      if (epoch < 10000000000) {
        return DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
      } else {
        return DateTime.fromMillisecondsSinceEpoch(epoch);
      }
    }

    return null;
  }
}

/// Custom parser with a provided function.
class _CustomDateParser extends DateParser {
  /// Creates a custom parser with a provided function.
  const _CustomDateParser(this._parser);
  final DateTime? Function(dynamic) _parser;

  @override
  DateTime? parse(dynamic value) => _parser(value);
}
