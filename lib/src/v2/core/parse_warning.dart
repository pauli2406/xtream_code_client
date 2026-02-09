/// A non-fatal parse diagnostic emitted while mapping server payloads.
class ParseWarning {
  /// Creates a parse warning.
  const ParseWarning({
    required this.code,
    required this.jsonPath,
    required this.rawValue,
    required this.message,
  });

  /// Stable warning identifier for programmatic handling.
  final String code;

  /// Location of the problematic value in the source payload.
  final String jsonPath;

  /// Original value that failed conversion or validation.
  final Object? rawValue;

  /// Human-readable explanation of the warning.
  final String message;

  @override
  String toString() {
    return 'ParseWarning('
        'code: $code, '
        'jsonPath: $jsonPath, '
        'rawValue: $rawValue, '
        'message: $message'
        ')';
  }
}
