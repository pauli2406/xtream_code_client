/// Parser for converting dynamic values to booleans.
abstract class BooleanParser {
  const BooleanParser();

  /// Parses a dynamic value to a boolean.
  bool parse(dynamic value);

  /// Creates a parser that handles flexible boolean parsing.
  factory BooleanParser.flexible() => const SmartBooleanParser();
}

/// Smart parser for booleans.
class SmartBooleanParser extends BooleanParser {
  const SmartBooleanParser();

  @override
  bool parse(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      return value == '1' || value.toLowerCase() == 'true';
    }
    if (value is num) {
      return value == 1;
    }
    return false;
  }
}

