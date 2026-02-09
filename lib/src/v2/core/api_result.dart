import 'package:xtream_code_client/src/v2/core/http_meta.dart';
import 'package:xtream_code_client/src/v2/core/parse_warning.dart';

/// Standard envelope returned by all v2 endpoint methods.
///
/// [data] contains the parsed model payload.
/// [warnings] contains non-fatal parse diagnostics (mainly in lenient mode).
/// [meta] contains request-level HTTP metadata.
class ApiResult<T> {
  /// Creates a typed API result.
  const ApiResult({
    required this.data,
    required this.warnings,
    required this.meta,
  });

  /// Parsed endpoint payload.
  final T data;

  /// Parse diagnostics collected while mapping the response.
  final List<ParseWarning> warnings;

  /// HTTP metadata for the request/response exchange.
  final HttpMeta meta;
}
