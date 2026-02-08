/// Parsing behavior for the v2 client.
enum ParseMode {
  lenient,
  strict,
}

/// Parsing options shared by all endpoint mappers.
class ParserOptions {
  const ParserOptions({this.mode = ParseMode.lenient});

  const ParserOptions.lenient() : mode = ParseMode.lenient;

  const ParserOptions.strict() : mode = ParseMode.strict;

  final ParseMode mode;

  bool get isStrict => mode == ParseMode.strict;
}
