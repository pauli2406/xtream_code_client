/// Controls how strictly incoming payload values are interpreted.
enum ParseMode {
  /// Keep parsing and emit warnings when a value cannot be converted.
  lenient,

  /// Fail fast when a value cannot be converted.
  strict,
}

/// Strategy used to decide whether parsing runs on a background isolate.
enum BackgroundParsingMode {
  /// Never use background isolates.
  off,

  /// Use payload-size thresholds to decide when to offload.
  auto,

  /// Always attempt to parse on a background isolate.
  always,
}

/// Parsing options shared by all v2 endpoint parsers.
///
/// Defaults are tuned for UI-heavy applications:
///
/// - [mode] = [ParseMode.lenient]
/// - [backgroundParsingMode] = [BackgroundParsingMode.auto]
/// - [jsonIsolateMinBytes] = 131072 (128 KiB)
/// - [xmlIsolateMinBytes] = 98304 (96 KiB)
///
/// In [BackgroundParsingMode.auto], a payload is offloaded only when its
/// response body byte size is greater than or equal to the corresponding
/// threshold.
class ParserOptions {
  /// Creates parser options with explicit values.
  const ParserOptions({
    this.mode = ParseMode.lenient,
    this.backgroundParsingMode = BackgroundParsingMode.auto,
    this.jsonIsolateMinBytes = 131072,
    this.xmlIsolateMinBytes = 98304,
  });

  /// Creates lenient parser options with default background parsing behavior.
  const ParserOptions.lenient()
      : mode = ParseMode.lenient,
        backgroundParsingMode = BackgroundParsingMode.auto,
        jsonIsolateMinBytes = 131072,
        xmlIsolateMinBytes = 98304;

  /// Creates strict parser options with default background parsing behavior.
  const ParserOptions.strict()
      : mode = ParseMode.strict,
        backgroundParsingMode = BackgroundParsingMode.auto,
        jsonIsolateMinBytes = 131072,
        xmlIsolateMinBytes = 98304;

  /// Parse strictness for field conversion and mapper behavior.
  final ParseMode mode;

  /// Background offload policy for parse jobs.
  final BackgroundParsingMode backgroundParsingMode;

  /// Minimum JSON payload size (bytes) for isolate offload in `auto` mode.
  ///
  /// Lower this when parse-heavy JSON endpoints cause UI jank.
  /// Raise it when isolate handoff overhead hurts throughput.
  final int jsonIsolateMinBytes;

  /// Minimum XML payload size (bytes) for isolate offload in `auto` mode.
  ///
  /// XML parsing is generally more CPU-intensive, so this default is lower than
  /// [jsonIsolateMinBytes].
  final int xmlIsolateMinBytes;

  /// Whether strict mode is currently enabled.
  bool get isStrict => mode == ParseMode.strict;
}
