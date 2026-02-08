import 'dart:isolate';

import 'package:xtream_code_client/src/v2/core/parse_executor.dart';
import 'package:xtream_code_client/src/v2/core/parser_options.dart';

/// Default [ParseExecutor] implementation.
///
/// In [BackgroundParsingMode.auto], parsing is offloaded when payload size is
/// greater than or equal to the corresponding threshold.
///
/// If isolate execution is unavailable (for example in some runtimes), this
/// executor falls back to synchronous parsing.
class DefaultParseExecutor extends ParseExecutor {
  /// Creates a default parse executor.
  const DefaultParseExecutor();

  @override
  Future<O> execute<I, O>({
    required I input,
    required ParseJob<I, O> job,
    required ParserOptions options,
    required ParsePayloadType payloadType,
    required int payloadBytes,
  }) async {
    if (!_shouldOffload(options, payloadType, payloadBytes)) {
      return job(input);
    }

    try {
      return await Isolate.run<O>(() => job(input));
    } catch (_) {
      // Web runtimes and some VM setups may reject isolate execution.
      return job(input);
    }
  }

  bool _shouldOffload(
    ParserOptions options,
    ParsePayloadType payloadType,
    int payloadBytes,
  ) {
    switch (options.backgroundParsingMode) {
      case BackgroundParsingMode.off:
        return false;
      case BackgroundParsingMode.always:
        return true;
      case BackgroundParsingMode.auto:
        final threshold = payloadType == ParsePayloadType.json
            ? options.jsonIsolateMinBytes
            : options.xmlIsolateMinBytes;
        return payloadBytes >= threshold;
    }
  }
}
