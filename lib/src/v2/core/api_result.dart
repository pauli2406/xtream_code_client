import 'package:xtream_code_client/src/v2/core/http_meta.dart';
import 'package:xtream_code_client/src/v2/core/parse_warning.dart';

/// Standard response envelope used by all v2 API methods.
class ApiResult<T> {
  const ApiResult({
    required this.data,
    required this.warnings,
    required this.meta,
  });

  final T data;
  final List<ParseWarning> warnings;
  final HttpMeta meta;
}
