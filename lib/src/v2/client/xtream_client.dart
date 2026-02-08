import 'package:http/http.dart' as http;
import 'package:xtream_code_client/src/epg_parser.dart';
import 'package:xtream_code_client/src/model/epg/epg.dart' show EPG;
import 'package:xtream_code_client/src/v2/core/api_result.dart';
import 'package:xtream_code_client/src/v2/core/http_meta.dart';
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/parser_options.dart';
import 'package:xtream_code_client/src/v2/core/request_exception.dart';
import 'package:xtream_code_client/src/v2/mapper/mappers.dart';
import 'package:xtream_code_client/src/v2/model/models.dart';
import 'package:xtream_code_client/src/v2/normalizer/response_normalizer.dart';

/// Canonical v2 client with resilient parsing and structured diagnostics.
class XtreamClient {
  XtreamClient({
    required String url,
    String? port,
    required String username,
    required String password,
    http.Client? httpClient,
    ParserOptions parserOptions = const ParserOptions(),
  })  : _http = httpClient ?? http.Client(),
        _parserOptions = parserOptions,
        _baseUrl = _buildPlayerApiUrl(url, port, username, password),
        _streamUrl = _buildStreamUrl(url, port, username, password),
        _movieUrl = _buildMovieUrl(url, port, username, password),
        _seriesUrl = _buildSeriesUrl(url, port, username, password);

  XtreamClient.fromResolvedUrls({
    required String baseUrl,
    required String streamUrl,
    required String movieUrl,
    required String seriesUrl,
    http.Client? httpClient,
    ParserOptions parserOptions = const ParserOptions(),
  })  : _http = httpClient ?? http.Client(),
        _parserOptions = parserOptions,
        _baseUrl = baseUrl,
        _streamUrl = streamUrl,
        _movieUrl = movieUrl,
        _seriesUrl = seriesUrl;

  final http.Client _http;
  final ParserOptions _parserOptions;

  final String _baseUrl;
  final String _streamUrl;
  final String _movieUrl;
  final String _seriesUrl;

  String get baseUrl => _baseUrl;

  String streamUrl(int id, List<String> allowedInputFormat) {
    final format = allowedInputFormat.firstWhere(
      (item) => item == 'ts',
      orElse: () => allowedInputFormat.first,
    );
    return '$_streamUrl/$id.$format';
  }

  String movieUrl(int id, String containerExtension) =>
      '$_movieUrl/$id.$containerExtension';

  String seriesUrl(int id, String containerExtension) =>
      '$_seriesUrl/$id.$containerExtension';

  Future<ApiResult<GeneralInformation>> serverInformation() async {
    final context = ParseContext(options: _parserOptions);
    final response = await _fetch(_baseUrl, context);
    final root =
        ResponseNormalizer.expectObject(response.payload, context, r'$');
    final data = GeneralInformationMapper.fromMap(root, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<GeneralInformation> serverInformationData() async {
    return (await serverInformation()).data;
  }

  Future<ApiResult<List<Category>>> liveStreamCategories() async {
    return _categories('get_live_categories');
  }

  Future<List<Category>> liveStreamCategoriesData() async {
    return (await liveStreamCategories()).data;
  }

  Future<ApiResult<List<Category>>> vodCategories() async {
    return _categories('get_vod_categories');
  }

  Future<List<Category>> vodCategoriesData() async {
    return (await vodCategories()).data;
  }

  Future<ApiResult<List<Category>>> seriesCategories() async {
    return _categories('get_series_categories');
  }

  Future<List<Category>> seriesCategoriesData() async {
    return (await seriesCategories()).data;
  }

  Future<ApiResult<List<LiveStreamItem>>> liveStreamItems({
    Category? category,
  }) async {
    var action = 'get_live_streams';
    if (category?.categoryId != null) {
      action = '$action&category_id=${category!.categoryId}';
    }

    final context = ParseContext(options: _parserOptions);
    final response = await _fetch('$_baseUrl&action=$action', context);
    final rows =
        ResponseNormalizer.expectObjectList(response.payload, context, r'$');
    final data = LiveStreamMapper.fromList(rows, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<List<LiveStreamItem>> liveStreamItemsData({
    Category? category,
  }) async {
    return (await liveStreamItems(category: category)).data;
  }

  Future<ApiResult<List<VodItem>>> vodItems({
    Category? category,
  }) async {
    var action = 'get_vod_streams';
    if (category?.categoryId != null) {
      action = '$action&category_id=${category!.categoryId}';
    }

    final context = ParseContext(options: _parserOptions);
    final response = await _fetch('$_baseUrl&action=$action', context);
    final rows =
        ResponseNormalizer.expectObjectList(response.payload, context, r'$');
    final data = VodMapper.itemsFromList(rows, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<List<VodItem>> vodItemsData({
    Category? category,
  }) async {
    return (await vodItems(category: category)).data;
  }

  Future<ApiResult<VodInfo>> vodInfo(VodItem vod) async {
    final action = 'get_vod_info&vod_id=${vod.streamId}';
    final context = ParseContext(options: _parserOptions);
    final response = await _fetch('$_baseUrl&action=$action', context);
    final root =
        ResponseNormalizer.expectObject(response.payload, context, r'$');
    final data = VodMapper.infoFromMap(root, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<VodInfo> vodInfoData(VodItem vod) async {
    return (await vodInfo(vod)).data;
  }

  Future<ApiResult<List<SeriesItem>>> seriesItems({
    Category? category,
  }) async {
    var action = 'get_series';
    if (category?.categoryId != null) {
      action = '$action&category_id=${category!.categoryId}';
    }

    final context = ParseContext(options: _parserOptions);
    final response = await _fetch('$_baseUrl&action=$action', context);
    final rows =
        ResponseNormalizer.expectObjectList(response.payload, context, r'$');
    final data = SeriesMapper.itemsFromList(rows, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<List<SeriesItem>> seriesItemsData({
    Category? category,
  }) async {
    return (await seriesItems(category: category)).data;
  }

  Future<ApiResult<SeriesInfo>> seriesInfo(SeriesItem series) async {
    final action = 'get_series_info&series_id=${series.seriesId}';
    final context = ParseContext(options: _parserOptions);
    final response = await _fetch('$_baseUrl&action=$action', context);
    final root =
        ResponseNormalizer.expectObject(response.payload, context, r'$');
    final data = SeriesMapper.infoFromMap(root, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<SeriesInfo> seriesInfoData(SeriesItem series) async {
    return (await seriesInfo(series)).data;
  }

  Future<ApiResult<ChannelEpg>> channelEpg(
    LiveStreamItem item,
    int? limit,
  ) async {
    if (item.streamId == null) {
      throw const RequestException(
          'streamId is required for channelEpg requests.');
    }
    return channelEpgViaStreamId(item.streamId!, limit);
  }

  Future<ChannelEpg> channelEpgData(
    LiveStreamItem item,
    int? limit,
  ) async {
    return (await channelEpg(item, limit)).data;
  }

  Future<ApiResult<ChannelEpg>> channelEpgViaStreamId(
    int streamId,
    int? limit,
  ) async {
    var action = 'get_short_epg&stream_id=$streamId';
    if (limit != null) {
      action = '$action&limit=$limit';
    }

    final context = ParseContext(options: _parserOptions);
    final response = await _fetch('$_baseUrl&action=$action', context);
    final root =
        ResponseNormalizer.expectObject(response.payload, context, r'$');
    final data = EpgMapper.channelEpgFromMap(root, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<ChannelEpg> channelEpgViaStreamIdData(
    int streamId,
    int? limit,
  ) async {
    return (await channelEpgViaStreamId(streamId, limit)).data;
  }

  Future<ApiResult<ChannelEpgTable>> channelEpgTable(
      LiveStreamItem item) async {
    if (item.streamId == null) {
      throw const RequestException(
          'streamId is required for channelEpgTable requests.');
    }

    final action = 'get_simple_data_table&stream_id=${item.streamId}';
    final context = ParseContext(options: _parserOptions);
    final response = await _fetch('$_baseUrl&action=$action', context);
    final root =
        ResponseNormalizer.expectObject(response.payload, context, r'$');
    final data = EpgMapper.channelEpgTableFromMap(root, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<ChannelEpgTable> channelEpgTableData(LiveStreamItem item) async {
    return (await channelEpgTable(item)).data;
  }

  Future<ApiResult<EPG>> epg() async {
    final uri = Uri.parse(_baseUrl.replaceFirst('player_api.php', 'xmltv.php'));
    final startedAt = DateTime.now();
    final response = await _http.get(uri);
    final meta = HttpMeta(
      requestUri: uri,
      statusCode: response.statusCode,
      headers: response.headers,
      duration: DateTime.now().difference(startedAt),
    );

    if (response.statusCode != 200) {
      throw RequestException(
        'Failed to fetch XMLTV data from $uri (status: ${response.statusCode}).',
      );
    }

    final parser = EpgParser();
    final data = parser.parse(response.body);
    return ApiResult(data: data, warnings: const [], meta: meta);
  }

  Future<EPG> epgData() async {
    return (await epg()).data;
  }

  void close() {
    _http.close();
  }

  Future<ApiResult<List<Category>>> _categories(String action) async {
    final context = ParseContext(options: _parserOptions);
    final response = await _fetch('$_baseUrl&action=$action', context);
    final rows =
        ResponseNormalizer.expectObjectList(response.payload, context, r'$');
    final data = CategoryMapper.fromList(rows, context, r'$');
    return ApiResult(
        data: data, warnings: context.warnings, meta: response.meta);
  }

  Future<_Payload> _fetch(String url, ParseContext context) async {
    final uri = Uri.parse(url);
    final startedAt = DateTime.now();
    final response = await _http.get(uri);
    final meta = HttpMeta(
      requestUri: uri,
      statusCode: response.statusCode,
      headers: response.headers,
      duration: DateTime.now().difference(startedAt),
    );

    if (response.statusCode != 200) {
      throw RequestException(
        'Request to $uri failed with status code ${response.statusCode}.',
      );
    }

    final payload =
        ResponseNormalizer.decodeJsonBody(response.body, context, r'$');
    return _Payload(payload: payload, meta: meta);
  }

  static String _buildPlayerApiUrl(
    String url,
    String? port,
    String username,
    String password,
  ) {
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    return '$url$portPart/player_api.php?username=$username&password=$password';
  }

  static String _buildStreamUrl(
    String url,
    String? port,
    String username,
    String password,
  ) {
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    return '$url$portPart/$username/$password';
  }

  static String _buildMovieUrl(
    String url,
    String? port,
    String username,
    String password,
  ) {
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    return '$url$portPart/movie/$username/$password';
  }

  static String _buildSeriesUrl(
    String url,
    String? port,
    String username,
    String password,
  ) {
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    return '$url$portPart/series/$username/$password';
  }
}

class _Payload {
  const _Payload({
    required this.payload,
    required this.meta,
  });

  final dynamic payload;
  final HttpMeta meta;
}
