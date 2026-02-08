import 'package:xtream_code_client/src/v2/core/parse_exception.dart';
import 'package:xtream_code_client/src/v2/core/parse_warning.dart';
import 'package:xtream_code_client/src/v2/core/parser_options.dart';

/// Mutable parsing context for collecting warnings across a response.
class ParseContext {
  ParseContext({ParserOptions options = const ParserOptions()})
      : _options = options;

  final ParserOptions _options;
  final List<ParseWarning> _warnings = <ParseWarning>[];

  List<ParseWarning> get warnings => List<ParseWarning>.unmodifiable(_warnings);

  ParserOptions get options => _options;

  void addWarning({
    required String code,
    required String jsonPath,
    required Object? rawValue,
    required String message,
  }) {
    final warning = ParseWarning(
      code: code,
      jsonPath: jsonPath,
      rawValue: rawValue,
      message: message,
    );

    if (_options.isStrict) {
      throw ParseException(warning);
    }

    _warnings.add(warning);
  }
}
