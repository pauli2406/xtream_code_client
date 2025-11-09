/// Parser for converting dynamic values to numbers.
abstract class NumberParser {
  const NumberParser();

  /// Parses a dynamic value to an integer.
  int? parseInt(dynamic value);

  /// Parses a dynamic value to a double.
  double? parseDouble(dynamic value);

  /// Creates a parser that handles flexible int parsing (string/int/double).
  factory NumberParser.intFlexible() => const SmartIntParser();

  /// Creates a parser that handles flexible double parsing (string/int/double).
  factory NumberParser.doubleFlexible() => const SmartDoubleParser();
}

/// Smart parser for integers.
class SmartIntParser extends NumberParser {
  const SmartIntParser();

  @override
  int? parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
      // Try as double then convert
      final doubleVal = double.tryParse(value);
      if (doubleVal != null) return doubleVal.toInt();
    }
    return null;
  }

  @override
  double? parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}

/// Smart parser for doubles.
class SmartDoubleParser extends NumberParser {
  const SmartDoubleParser();

  @override
  int? parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
      final doubleVal = double.tryParse(value);
      if (doubleVal != null) return doubleVal.toInt();
    }
    return null;
  }

  @override
  double? parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}

