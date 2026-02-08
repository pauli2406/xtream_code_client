import 'package:xtream_code_client/src/v2/core/parser_options.dart';

/// Parse payload category used for background execution decisions.
enum ParsePayloadType {
  /// JSON payload.
  json,

  /// XML payload.
  xml,
}

/// Top-level parse function signature executed by a [ParseExecutor].
typedef ParseJob<I, O> = O Function(I input);

/// Executes parse jobs either in the current isolate or on a background
/// isolate.
abstract class ParseExecutor {
  /// Creates a parse executor.
  const ParseExecutor();

  /// Executes [job] for [input] based on [options], payload type, and payload
  /// size.
  Future<O> execute<I, O>({
    required I input,
    required ParseJob<I, O> job,
    required ParserOptions options,
    required ParsePayloadType payloadType,
    required int payloadBytes,
  });
}
