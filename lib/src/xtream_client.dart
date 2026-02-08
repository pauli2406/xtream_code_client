import 'package:http/http.dart';
import 'package:xtream_code_client/src/model/category.dart';
import 'package:xtream_code_client/src/model/channel_epg.dart';
import 'package:xtream_code_client/src/model/channel_epg_table.dart';
import 'package:xtream_code_client/src/model/epg/epg.dart';
import 'package:xtream_code_client/src/model/general_information.dart';
import 'package:xtream_code_client/src/model/live_stream_items.dart';
import 'package:xtream_code_client/src/model/series_info.dart';
import 'package:xtream_code_client/src/model/series_items.dart';
import 'package:xtream_code_client/src/model/vod_info.dart';
import 'package:xtream_code_client/src/model/vod_items.dart';
import 'package:xtream_code_client/src/v2/compat/legacy_xtream_client.dart';

/// Legacy API wrapper. Prefer `XtreamClient` from `src/v2/client`.
@Deprecated('Use XtreamClient from src/v2/client/xtream_client.dart')
class XtreamCodeClient {
  /// Creates a legacy API client that delegates to v2 internals.
  XtreamCodeClient(
    String baseUrl,
    String streamUrl,
    String movieUrl,
    String seriesUrl,
    Client httpClient,
  ) : _delegate = LegacyXtreamCodeClient(
          baseUrl: baseUrl,
          streamUrl: streamUrl,
          movieUrl: movieUrl,
          seriesUrl: seriesUrl,
          httpClient: httpClient,
        );

  final LegacyXtreamCodeClient _delegate;

  /// Legacy player API URL with embedded credentials.
  String get baseUrl => _delegate.baseUrl;

  /// Builds a live stream playback URL.
  String streamUrl(int id, List<String> allowedInputFormat) =>
      _delegate.streamUrl(id, allowedInputFormat);

  /// Builds a movie playback URL.
  String movieUrl(int id, String containerExtension) =>
      _delegate.movieUrl(id, containerExtension);

  /// Builds a series playback URL.
  String seriesUrl(int id, String containerExtension) =>
      _delegate.seriesUrl(id, containerExtension);

  /// Loads account and server information.
  Future<XTremeCodeGeneralInformation> serverInformation() =>
      _delegate.serverInformation();

  /// Loads live stream categories.
  Future<List<XTremeCodeCategory>> liveStreamCategories() =>
      _delegate.liveStreamCategories();

  /// Loads VOD categories.
  Future<List<XTremeCodeCategory>> vodCategories() => _delegate.vodCategories();

  /// Loads series categories.
  Future<List<XTremeCodeCategory>> seriesCategories() =>
      _delegate.seriesCategories();

  /// Loads live stream items, optionally filtered by category.
  Future<List<XTremeCodeLiveStreamItem>> livestreamItems({
    XTremeCodeCategory? category,
  }) =>
      _delegate.livestreamItems(category: category);

  /// Loads VOD items, optionally filtered by category.
  Future<List<XTremeCodeVodItem>> vodItems({
    XTremeCodeCategory? category,
  }) =>
      _delegate.vodItems(category: category);

  /// Loads detailed VOD metadata.
  Future<XTremeCodeVodInfo> vodInfo(XTremeCodeVodItem vod) =>
      _delegate.vodInfo(vod);

  /// Loads series items, optionally filtered by category.
  Future<List<XTremeCodeSeriesItem>> seriesItems({
    XTremeCodeCategory? category,
  }) =>
      _delegate.seriesItems(category: category);

  /// Loads detailed series metadata.
  Future<XTremeCodeSeriesInfo> seriesInfo(XTremeCodeSeriesItem series) =>
      _delegate.seriesInfo(series);

  /// Loads short EPG entries for a stream item.
  Future<XTremeCodeChannelEpg> channelEpg(
    XTremeCodeLiveStreamItem item,
    int? limit,
  ) =>
      _delegate.channelEpg(item, limit);

  /// Loads short EPG entries directly by stream id.
  Future<XTremeCodeChannelEpg> channelEpgViaStreamId(
    int streamId,
    int? limit,
  ) =>
      _delegate.channelEpgViaStreamId(streamId, limit);

  /// Loads simple EPG table entries for a stream item.
  Future<XTremeCodeChannelEpgTable> channelEpgTable(
    XTremeCodeLiveStreamItem item,
  ) =>
      _delegate.channelEpgTable(item);

  /// Loads full XMLTV EPG.
  Future<EPG> epg() => _delegate.epg();
}
