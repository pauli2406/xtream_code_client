import 'package:xtream_code_client/src/parser/boolean_parser.dart';
import 'package:xtream_code_client/src/parser/date_parser.dart';
import 'package:xtream_code_client/src/parser/list_parser.dart';
import 'package:xtream_code_client/src/parser/number_parser.dart';

/// Configuration for parsing JSON values with flexible format handling.
///
/// This class allows you to configure how different fields are parsed,
/// with smart defaults that automatically detect formats.
///
/// Example:
/// ```dart
/// // Use default smart parsers (works out of the box)
/// final config = ParserConfig.defaultConfig();
///
/// // Override specific fields
/// final config = ParserConfig.override(
///   dateFieldParsers: {
///     'end': DateParser.epochSeconds(),
///   },
/// );
/// ```
class ParserConfig {
  /// Default date parser (smart auto-detection).
  final DateParser defaultDateParser;

  /// Field-specific date parsers (overrides default).
  final Map<String, DateParser> dateFieldParsers;

  /// Default integer parser (flexible).
  final NumberParser defaultIntParser;

  /// Default double parser (flexible).
  final NumberParser defaultDoubleParser;

  /// Field-specific number parsers (overrides default).
  final Map<String, NumberParser> numberFieldParsers;

  /// Default boolean parser (flexible).
  final BooleanParser defaultBoolParser;

  /// Field-specific boolean parsers (overrides default).
  final Map<String, BooleanParser> boolFieldParsers;

  /// Default string list parser.
  final ListParser defaultStringListParser;

  /// Default integer list parser.
  final ListParser defaultIntListParser;

  /// Creates a parser configuration with smart defaults.
  const ParserConfig({
    this.defaultDateParser = const SmartDateParser(),
    this.dateFieldParsers = const {},
    this.defaultIntParser = const SmartIntParser(),
    this.defaultDoubleParser = const SmartDoubleParser(),
    this.numberFieldParsers = const {},
    this.defaultBoolParser = const SmartBooleanParser(),
    this.boolFieldParsers = const {},
    this.defaultStringListParser = const SmartStringListParser(),
    this.defaultIntListParser = const SmartIntListParser(),
  });

  /// Creates a default parser configuration with smart auto-detection.
  factory ParserConfig.defaultConfig() => const ParserConfig();

  /// Creates a parser configuration with field-specific overrides.
  ///
  /// Only specify the fields you want to override. All other fields
  /// will use the smart defaults.
  factory ParserConfig.override({
    Map<String, DateParser>? dateFieldParsers,
    Map<String, NumberParser>? numberFieldParsers,
    Map<String, BooleanParser>? boolFieldParsers,
  }) {
    return ParserConfig(
      dateFieldParsers: dateFieldParsers ?? const {},
      numberFieldParsers: numberFieldParsers ?? const {},
      boolFieldParsers: boolFieldParsers ?? const {},
    );
  }

  /// Gets the date parser for a specific field.
  DateParser getDateParser(String fieldName) {
    return dateFieldParsers[fieldName] ?? defaultDateParser;
  }

  /// Gets the integer parser for a specific field.
  NumberParser getIntParser(String fieldName) {
    return numberFieldParsers[fieldName] ?? defaultIntParser;
  }

  /// Gets the double parser for a specific field.
  NumberParser getDoubleParser(String fieldName) {
    return numberFieldParsers[fieldName] ?? defaultDoubleParser;
  }

  /// Gets the boolean parser for a specific field.
  BooleanParser getBoolParser(String fieldName) {
    return boolFieldParsers[fieldName] ?? defaultBoolParser;
  }

  /// Gets the string list parser.
  ListParser getStringListParser() => defaultStringListParser;

  /// Gets the integer list parser.
  ListParser getIntListParser() => defaultIntListParser;
}

