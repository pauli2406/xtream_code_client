/// Public package exports for Xtream Code Client.
///
/// Recommended surface for new integrations:
///
/// - `XtreamClient`
/// - `ApiResult<T>`
/// - v2 models from `src/v2/model/*`
///
/// Legacy `XtreamCode`, `XtreamCodeClient`, and `XTremeCode*` types are kept
/// for migration compatibility and are deprecated.
library xtream_code_client;

export 'src/epg_parser.dart';
export 'src/exception/xtream_code_client_exception.dart';
export 'src/model/category.dart';
export 'src/model/channel_epg.dart';
export 'src/model/channel_epg_table.dart';
export 'src/model/epg/epg.dart' hide Category;
export 'src/model/general_information.dart';
export 'src/model/live_stream_items.dart';
export 'src/model/series_info.dart';
export 'src/model/series_items.dart';
export 'src/model/server_info.dart';
export 'src/model/user_info.dart';
export 'src/model/vod_info.dart';
export 'src/model/vod_items.dart';
export 'src/v2/client/endpoint_config.dart';
export 'src/v2/client/xtream_client.dart';
export 'src/v2/core/api_result.dart';
export 'src/v2/core/http_meta.dart';
export 'src/v2/core/parse_exception.dart';
export 'src/v2/core/parse_executor.dart';
export 'src/v2/core/parse_executor_default.dart';
export 'src/v2/core/parse_warning.dart';
export 'src/v2/core/parser_options.dart';
export 'src/v2/core/request_exception.dart';
export 'src/v2/model/models.dart';
export 'src/xtream_client.dart';
export 'src/xtream_code_client.dart';
