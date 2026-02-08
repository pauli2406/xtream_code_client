/// Structured warning emitted when a field cannot be parsed cleanly.
class ParseWarning {
  const ParseWarning({
    required this.code,
    required this.jsonPath,
    required this.rawValue,
    required this.message,
  });

  final String code;
  final String jsonPath;
  final Object? rawValue;
  final String message;

  @override
  String toString() {
    return 'ParseWarning(code: $code, jsonPath: $jsonPath, rawValue: $rawValue, message: $message)';
  }
}
