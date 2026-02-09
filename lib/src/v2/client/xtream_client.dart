import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xtream_code_client/src/model/epg/epg.dart' show EPG;
import 'package:xtream_code_client/src/v2/client/endpoint_config.dart';
import 'package:xtream_code_client/src/v2/client/parse_jobs.dart';
import 'package:xtream_code_client/src/v2/core/api_result.dart';
import 'package:xtream_code_client/src/v2/core/http_meta.dart';
import 'package:xtream_code_client/src/v2/core/parse_executor.dart';
import 'package:xtream_code_client/src/v2/core/parse_executor_default.dart';
import 'package:xtream_code_client/src/v2/core/parser_options.dart';
import 'package:xtream_code_client/src/v2/core/request_exception.dart';
import 'package:xtream_code_client/src/v2/model/models.dart';

/// Canonical v2 client with resilient parsing and structured diagnostics.
class XtreamClient {
  /// Creates a v2 Xtream client from base connection details.
  ///
  /// The client builds endpoint URLs from [url], optional [port], credentials,
  /// and [endpointConfig].
  ///
  /// Use [parserOptions] to control strictness and background parsing
  /// thresholds.
  XtreamClient({
    required String url,
    String? port,
    required String username,
    required String password,
    http.Client? httpClient,
    ParserOptions parserOptions = const ParserOptions(),
    EndpointConfig endpointConfig = const EndpointConfig(),
    ParseExecutor parseExecutor = const DefaultParseExecutor(),
  }) : this._fromResolved(
          resolved: _ResolvedUrls.fromConnection(
            url: url,
            port: port,
            username: username,
            password: password,
            endpointConfig: endpointConfig,
          ),
          httpClient: httpClient,
          parserOptions: parserOptions,
          parseExecutor: parseExecutor,
        );

  /// Creates a v2 client from already-resolved endpoint URLs.
  ///
  /// This is useful for integrations that receive prebuilt URLs from external
  /// configuration or a legacy adapter.
  XtreamClient.fromResolvedUrls({
    required String baseUrl,
    required String streamUrl,
    required String movieUrl,
    required String seriesUrl,
    http.Client? httpClient,
    ParserOptions parserOptions = const ParserOptions(),
    EndpointConfig endpointConfig = const EndpointConfig(),
    ParseExecutor parseExecutor = const DefaultParseExecutor(),
  }) : this._fromResolved(
          resolved: _ResolvedUrls.fromResolvedUrls(
            baseUrl: baseUrl,
            streamUrl: streamUrl,
            movieUrl: movieUrl,
            seriesUrl: seriesUrl,
            endpointConfig: endpointConfig,
          ),
          httpClient: httpClient,
          parserOptions: parserOptions,
          parseExecutor: parseExecutor,
        );

  XtreamClient._fromResolved({
    required _ResolvedUrls resolved,
    http.Client? httpClient,
    ParserOptions parserOptions = const ParserOptions(),
    ParseExecutor parseExecutor = const DefaultParseExecutor(),
  })  : _http = httpClient ?? http.Client(),
        _parserOptions = parserOptions,
        _parseExecutor = parseExecutor,
        _playerApiUri = resolved.playerApiUri,
        _xmltvUri = resolved.xmltvUri,
        _playlistUri = resolved.playlistUri,
        _streamBaseUri = resolved.streamBaseUri,
        _movieBaseUri = resolved.movieBaseUri,
        _seriesBaseUri = resolved.seriesBaseUri;

  final http.Client _http;
  final ParserOptions _parserOptions;
  final ParseExecutor _parseExecutor;

  final Uri _playerApiUri;
  final Uri _xmltvUri;
  final Uri _playlistUri;
  final Uri _streamBaseUri;
  final Uri _movieBaseUri;
  final Uri _seriesBaseUri;

  /// Fully resolved player API base URL with credentials.
  String get baseUrl => _playerApiUri.toString();

  /// Builds a live stream playback URL for a stream [id].
  ///
  /// Prefers `ts` when it is present in [allowedInputFormat].
  String streamUrl(int id, List<String> allowedInputFormat) {
    final format = _preferredOutputFormat(allowedInputFormat);
    return _appendPath(_streamBaseUri, '$id.$format').toString();
  }

  /// Builds a movie playback URL for VOD stream [id].
  String movieUrl(int id, String containerExtension) {
    return _appendPath(_movieBaseUri, '$id.$containerExtension').toString();
  }

  /// Builds a series episode playback URL for episode [id].
  String seriesUrl(int id, String containerExtension) {
    return _appendPath(_seriesBaseUri, '$id.$containerExtension').toString();
  }

  /// Builds an M3U playlist [Uri].
  ///
  /// Defaults to `m3u_plus` and `ts` output format.
  Uri m3uPlaylistUri({
    String type = 'm3u_plus',
    String output = 'ts',
    Map<String, String> extraQuery = const <String, String>{},
  }) {
    return _playlistUri.replace(
      queryParameters: <String, String>{
        ..._playlistUri.queryParameters,
        'type': type,
        'output': output,
        ...extraQuery,
      },
    );
  }

  /// Builds an M3U playlist URL string.
  String m3uPlaylistUrl({
    String type = 'm3u_plus',
    String output = 'ts',
    Map<String, String> extraQuery = const <String, String>{},
  }) {
    return m3uPlaylistUri(
      type: type,
      output: output,
      extraQuery: extraQuery,
    ).toString();
  }

  /// Loads account and server information.
  Future<ApiResult<GeneralInformation>> serverInformation() {
    return _requestJson(
      uri: _playerApiUri,
      parser: parseGeneralInformation,
    );
  }

  /// Convenience version of [serverInformation] that returns only `data`.
  Future<GeneralInformation> serverInformationData() async {
    return (await serverInformation()).data;
  }

  /// Loads live stream categories.
  Future<ApiResult<List<Category>>> liveStreamCategories() {
    return _categories('get_live_categories');
  }

  /// Convenience version of [liveStreamCategories] that returns only `data`.
  Future<List<Category>> liveStreamCategoriesData() async {
    return (await liveStreamCategories()).data;
  }

  /// Loads VOD categories.
  Future<ApiResult<List<Category>>> vodCategories() {
    return _categories('get_vod_categories');
  }

  /// Convenience version of [vodCategories] that returns only `data`.
  Future<List<Category>> vodCategoriesData() async {
    return (await vodCategories()).data;
  }

  /// Loads series categories.
  Future<ApiResult<List<Category>>> seriesCategories() {
    return _categories('get_series_categories');
  }

  /// Convenience version of [seriesCategories] that returns only `data`.
  Future<List<Category>> seriesCategoriesData() async {
    return (await seriesCategories()).data;
  }

  /// Loads live stream items, optionally filtered by [category].
  Future<ApiResult<List<LiveStreamItem>>> liveStreamItems({
    Category? category,
  }) {
    final query = <String, String>{
      if (category?.categoryId != null)
        'category_id': category!.categoryId.toString(),
    };

    return _requestJson(
      uri: _actionUri('get_live_streams', extraQuery: query),
      parser: parseLiveStreamItems,
    );
  }

  /// Convenience version of [liveStreamItems] that returns only `data`.
  Future<List<LiveStreamItem>> liveStreamItemsData({
    Category? category,
  }) async {
    return (await liveStreamItems(category: category)).data;
  }

  /// Loads VOD items, optionally filtered by [category].
  Future<ApiResult<List<VodItem>>> vodItems({
    Category? category,
  }) {
    final query = <String, String>{
      if (category?.categoryId != null)
        'category_id': category!.categoryId.toString(),
    };

    return _requestJson(
      uri: _actionUri('get_vod_streams', extraQuery: query),
      parser: parseVodItems,
    );
  }

  /// Convenience version of [vodItems] that returns only `data`.
  Future<List<VodItem>> vodItemsData({
    Category? category,
  }) async {
    return (await vodItems(category: category)).data;
  }

  /// Loads full VOD info for a VOD item.
  ///
  /// Throws [RequestException] when `vod.streamId` is null.
  Future<ApiResult<VodInfo>> vodInfo(VodItem vod) {
    if (vod.streamId == null) {
      throw const RequestException(
        'streamId is required for vodInfo requests.',
      );
    }

    return _requestJson(
      uri: _actionUri(
        'get_vod_info',
        extraQuery: <String, String>{
          'vod_id': vod.streamId!.toString(),
        },
      ),
      parser: parseVodInfo,
    );
  }

  /// Convenience version of [vodInfo] that returns only `data`.
  Future<VodInfo> vodInfoData(VodItem vod) async {
    return (await vodInfo(vod)).data;
  }

  /// Loads series items, optionally filtered by [category].
  Future<ApiResult<List<SeriesItem>>> seriesItems({
    Category? category,
  }) {
    final query = <String, String>{
      if (category?.categoryId != null)
        'category_id': category!.categoryId.toString(),
    };

    return _requestJson(
      uri: _actionUri('get_series', extraQuery: query),
      parser: parseSeriesItems,
    );
  }

  /// Convenience version of [seriesItems] that returns only `data`.
  Future<List<SeriesItem>> seriesItemsData({
    Category? category,
  }) async {
    return (await seriesItems(category: category)).data;
  }

  /// Loads full series info for a series item.
  ///
  /// Throws [RequestException] when `series.seriesId` is null.
  Future<ApiResult<SeriesInfo>> seriesInfo(SeriesItem series) {
    if (series.seriesId == null) {
      throw const RequestException(
        'seriesId is required for seriesInfo requests.',
      );
    }

    return _requestJson(
      uri: _actionUri(
        'get_series_info',
        extraQuery: <String, String>{
          'series_id': series.seriesId!.toString(),
        },
      ),
      parser: parseSeriesInfo,
    );
  }

  /// Convenience version of [seriesInfo] that returns only `data`.
  Future<SeriesInfo> seriesInfoData(SeriesItem series) async {
    return (await seriesInfo(series)).data;
  }

  /// Loads short EPG data for a stream item.
  ///
  /// Throws [RequestException] when `item.streamId` is null.
  Future<ApiResult<ChannelEpg>> channelEpg(
    LiveStreamItem item,
    int? limit,
  ) async {
    if (item.streamId == null) {
      throw const RequestException(
        'streamId is required for channelEpg requests.',
      );
    }
    return channelEpgViaStreamId(item.streamId!, limit);
  }

  /// Convenience version of [channelEpg] that returns only `data`.
  Future<ChannelEpg> channelEpgData(
    LiveStreamItem item,
    int? limit,
  ) async {
    return (await channelEpg(item, limit)).data;
  }

  /// Loads short EPG data by stream id.
  Future<ApiResult<ChannelEpg>> channelEpgViaStreamId(
    int streamId,
    int? limit,
  ) {
    final query = <String, String>{
      'stream_id': streamId.toString(),
      if (limit != null) 'limit': limit.toString(),
    };

    return _requestJson(
      uri: _actionUri('get_short_epg', extraQuery: query),
      parser: parseChannelEpg,
    );
  }

  /// Convenience version of [channelEpgViaStreamId] that returns only `data`.
  Future<ChannelEpg> channelEpgViaStreamIdData(
    int streamId,
    int? limit,
  ) async {
    return (await channelEpgViaStreamId(streamId, limit)).data;
  }

  /// Loads EPG table data for a stream item.
  ///
  /// Throws [RequestException] when `item.streamId` is null.
  Future<ApiResult<ChannelEpgTable>> channelEpgTable(
    LiveStreamItem item,
  ) async {
    if (item.streamId == null) {
      throw const RequestException(
        'streamId is required for channelEpgTable requests.',
      );
    }

    return _requestJson(
      uri: _actionUri(
        'get_simple_data_table',
        extraQuery: <String, String>{
          'stream_id': item.streamId.toString(),
        },
      ),
      parser: parseChannelEpgTable,
    );
  }

  /// Convenience version of [channelEpgTable] that returns only `data`.
  Future<ChannelEpgTable> channelEpgTableData(LiveStreamItem item) async {
    return (await channelEpgTable(item)).data;
  }

  /// Loads full XMLTV EPG and parses it into [EPG].
  Future<ApiResult<EPG>> epg() {
    return _requestXml(uri: _xmltvUri, parser: parseFullEpg);
  }

  /// Convenience version of [epg] that returns only `data`.
  Future<EPG> epgData() async {
    return (await epg()).data;
  }

  /// Loads XMLTV and parses a lightweight EPG model.
  Future<ApiResult<EpgLite>> epgLite() {
    return _requestXml(uri: _xmltvUri, parser: parseLiteEpg);
  }

  /// Convenience version of [epgLite] that returns only `data`.
  Future<EpgLite> epgLiteData() async {
    return (await epgLite()).data;
  }

  /// Closes the underlying HTTP client.
  void close() {
    _http.close();
  }

  Future<ApiResult<List<Category>>> _categories(String action) {
    return _requestJson(
      uri: _actionUri(action),
      parser: parseCategoryList,
    );
  }

  Uri _actionUri(
    String action, {
    Map<String, String> extraQuery = const <String, String>{},
  }) {
    return _playerApiUri.replace(
      queryParameters: <String, String>{
        ..._playerApiUri.queryParameters,
        'action': action,
        ...extraQuery,
      },
    );
  }

  Future<ApiResult<T>> _requestJson<T>({
    required Uri uri,
    required JsonParseResult<T> Function(JsonParseRequest request) parser,
  }) async {
    final response = await _fetch(uri);
    final parseRequest = JsonParseRequest(
      body: response.body,
      mode: _parserOptions.mode,
    );

    final parsed =
        await _parseExecutor.execute<JsonParseRequest, JsonParseResult<T>>(
      input: parseRequest,
      job: parser,
      options: _parserOptions,
      payloadType: ParsePayloadType.json,
      payloadBytes: response.sizeBytes,
    );

    return ApiResult(
      data: parsed.data,
      warnings: parsed.warnings,
      meta: response.meta,
    );
  }

  Future<ApiResult<T>> _requestXml<T>({
    required Uri uri,
    required T Function(String xml) parser,
  }) async {
    final response = await _fetch(uri);
    final data = await _parseExecutor.execute<String, T>(
      input: response.body,
      job: parser,
      options: _parserOptions,
      payloadType: ParsePayloadType.xml,
      payloadBytes: response.sizeBytes,
    );

    return ApiResult(
      data: data,
      warnings: const [],
      meta: response.meta,
    );
  }

  Future<_RawResponse> _fetch(Uri uri) async {
    final startedAt = DateTime.now();
    final response = await _http.get(uri);
    final bodyBytes = response.bodyBytes;

    final meta = HttpMeta(
      requestUri: uri,
      statusCode: response.statusCode,
      headers: response.headers,
      duration: DateTime.now().difference(startedAt),
    );

    if (response.statusCode != 200) {
      final safeUri = _redactedUriForError(uri);
      throw RequestException(
        'Request to $safeUri failed with status code ${response.statusCode}.',
      );
    }

    final body = utf8.decode(bodyBytes);
    return _RawResponse(
      body: body,
      sizeBytes: bodyBytes.length,
      meta: meta,
    );
  }

  static String _preferredOutputFormat(List<String> allowedInputFormat) {
    if (allowedInputFormat.isEmpty) {
      return 'ts';
    }
    return allowedInputFormat.firstWhere(
      (item) => item == 'ts',
      orElse: () => allowedInputFormat.first,
    );
  }

  static Uri _appendPath(Uri baseUri, String path) {
    final normalized = _normalizePath(path);
    final segments = <String>[
      ...baseUri.pathSegments.where((segment) => segment.isNotEmpty),
      ...normalized.split('/').where((segment) => segment.isNotEmpty),
    ];
    return baseUri.replace(pathSegments: segments);
  }

  static String _normalizePath(String path) {
    var normalized = path.trim();
    while (normalized.startsWith('/')) {
      normalized = normalized.substring(1);
    }
    return normalized;
  }

  static Uri _redactedUriForError(Uri uri) {
    final username = uri.queryParameters['username'];
    final password = uri.queryParameters['password'];
    final pathSegments = uri.pathSegments.map((segment) {
      if (segment.isEmpty) {
        return segment;
      }
      if ((username != null && segment == username) ||
          (password != null && segment == password)) {
        return '***';
      }
      return segment;
    }).toList();

    final redactedQuery = <String, String>{};
    for (final entry in uri.queryParameters.entries) {
      redactedQuery[entry.key] =
          _isSensitiveQueryKey(entry.key) ? '***' : entry.value;
    }

    return uri.replace(
      userInfo: uri.userInfo.isEmpty ? null : '***',
      pathSegments: pathSegments,
      queryParameters: uri.hasQuery ? redactedQuery : null,
    );
  }

  static bool _isSensitiveQueryKey(String key) {
    final normalized = key.toLowerCase();
    return normalized == 'username' ||
        normalized == 'user' ||
        normalized == 'password' ||
        normalized == 'pass' ||
        normalized == 'pwd' ||
        normalized == 'auth' ||
        normalized == 'authorization' ||
        normalized == 'apikey' ||
        normalized == 'api_key' ||
        normalized.contains('token') ||
        normalized.contains('secret') ||
        normalized.contains('password');
  }
}

class _RawResponse {
  const _RawResponse({
    required this.body,
    required this.sizeBytes,
    required this.meta,
  });

  final String body;
  final int sizeBytes;
  final HttpMeta meta;
}

class _ResolvedUrls {
  const _ResolvedUrls({
    required this.playerApiUri,
    required this.xmltvUri,
    required this.playlistUri,
    required this.streamBaseUri,
    required this.movieBaseUri,
    required this.seriesBaseUri,
  });

  factory _ResolvedUrls.fromConnection({
    required String url,
    String? port,
    required String username,
    required String password,
    required EndpointConfig endpointConfig,
  }) {
    final root = _rootUri(url, port);
    final authQuery = <String, String>{
      ...endpointConfig.defaultQueryParameters,
      'username': username,
      'password': password,
    };

    return _ResolvedUrls(
      playerApiUri: XtreamClient._appendPath(root, endpointConfig.playerApiPath)
          .replace(queryParameters: authQuery),
      xmltvUri: XtreamClient._appendPath(root, endpointConfig.xmltvPath)
          .replace(queryParameters: authQuery),
      playlistUri: XtreamClient._appendPath(root, endpointConfig.playlistPath)
          .replace(queryParameters: authQuery),
      streamBaseUri: XtreamClient._appendPath(root, '$username/$password'),
      movieBaseUri: XtreamClient._appendPath(root, 'movie/$username/$password'),
      seriesBaseUri:
          XtreamClient._appendPath(root, 'series/$username/$password'),
    );
  }

  factory _ResolvedUrls.fromResolvedUrls({
    required String baseUrl,
    required String streamUrl,
    required String movieUrl,
    required String seriesUrl,
    required EndpointConfig endpointConfig,
  }) {
    final playerApiUri = Uri.parse(baseUrl);
    final streamBaseUri = Uri.parse(streamUrl);
    final movieBaseUri = Uri.parse(movieUrl);
    final seriesBaseUri = Uri.parse(seriesUrl);

    final credentials = _inferCredentials(
      playerApiUri,
      streamBaseUri,
      movieBaseUri,
      seriesBaseUri,
    );

    final authQuery = <String, String>{
      ...endpointConfig.defaultQueryParameters,
      if (credentials != null) ...credentials.queryParameters,
    };

    final rootPathSegments = <String>[
      ...playerApiUri.pathSegments.where((segment) => segment.isNotEmpty),
    ];
    if (rootPathSegments.isNotEmpty) {
      rootPathSegments.removeLast();
    }

    final root = playerApiUri.replace(
      pathSegments: rootPathSegments,
      queryParameters: const <String, String>{},
      fragment: '',
    );

    return _ResolvedUrls(
      playerApiUri: playerApiUri,
      xmltvUri: XtreamClient._appendPath(root, endpointConfig.xmltvPath)
          .replace(queryParameters: authQuery),
      playlistUri: XtreamClient._appendPath(root, endpointConfig.playlistPath)
          .replace(queryParameters: authQuery),
      streamBaseUri: streamBaseUri,
      movieBaseUri: movieBaseUri,
      seriesBaseUri: seriesBaseUri,
    );
  }

  final Uri playerApiUri;
  final Uri xmltvUri;
  final Uri playlistUri;
  final Uri streamBaseUri;
  final Uri movieBaseUri;
  final Uri seriesBaseUri;

  static Uri _rootUri(String url, String? port) {
    final trimmed = url.trim().endsWith('/')
        ? url.trim().substring(0, url.trim().length - 1)
        : url.trim();
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    return Uri.parse('$trimmed$portPart');
  }

  static _Credentials? _inferCredentials(
    Uri playerApiUri,
    Uri streamUri,
    Uri movieUri,
    Uri seriesUri,
  ) {
    final queryUsername = playerApiUri.queryParameters['username'];
    final queryPassword = playerApiUri.queryParameters['password'];
    if (queryUsername != null && queryPassword != null) {
      return _Credentials(username: queryUsername, password: queryPassword);
    }

    return _pathCredentials(streamUri) ??
        _pathCredentials(movieUri) ??
        _pathCredentials(seriesUri);
  }

  static _Credentials? _pathCredentials(Uri uri) {
    final segments =
        uri.pathSegments.where((segment) => segment.isNotEmpty).toList();
    if (segments.length < 2) {
      return null;
    }
    return _Credentials(
      username: segments[segments.length - 2],
      password: segments[segments.length - 1],
    );
  }
}

class _Credentials {
  const _Credentials({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  Map<String, String> get queryParameters => <String, String>{
        'username': username,
        'password': password,
      };
}
