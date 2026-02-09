import 'package:xtream_code_client/src/v2/core/parse_warning.dart';

/// Exception thrown when strict parsing is enabled and a warning is emitted.
class ParseException implements Exception {
  const ParseException(this.warning);

  final ParseWarning warning;

  @override
  String toString() => 'ParseException($warning)';
}
