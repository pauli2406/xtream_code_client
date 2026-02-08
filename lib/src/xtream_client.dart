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

  String get baseUrl => _delegate.baseUrl;

  String streamUrl(int id, List<String> allowedInputFormat) =>
      _delegate.streamUrl(id, allowedInputFormat);

  String movieUrl(int id, String containerExtension) =>
      _delegate.movieUrl(id, containerExtension);

  String seriesUrl(int id, String containerExtension) =>
      _delegate.seriesUrl(id, containerExtension);

  Future<XTremeCodeGeneralInformation> serverInformation() =>
      _delegate.serverInformation();

  Future<List<XTremeCodeCategory>> liveStreamCategories() =>
      _delegate.liveStreamCategories();

  Future<List<XTremeCodeCategory>> vodCategories() => _delegate.vodCategories();

  Future<List<XTremeCodeCategory>> seriesCategories() =>
      _delegate.seriesCategories();

  Future<List<XTremeCodeLiveStreamItem>> livestreamItems({
    XTremeCodeCategory? category,
  }) =>
      _delegate.livestreamItems(category: category);

  Future<List<XTremeCodeVodItem>> vodItems({
    XTremeCodeCategory? category,
  }) =>
      _delegate.vodItems(category: category);

  Future<XTremeCodeVodInfo> vodInfo(XTremeCodeVodItem vod) =>
      _delegate.vodInfo(vod);

  Future<List<XTremeCodeSeriesItem>> seriesItems({
    XTremeCodeCategory? category,
  }) =>
      _delegate.seriesItems(category: category);

  Future<XTremeCodeSeriesInfo> seriesInfo(XTremeCodeSeriesItem series) =>
      _delegate.seriesInfo(series);

  Future<XTremeCodeChannelEpg> channelEpg(
    XTremeCodeLiveStreamItem item,
    int? limit,
  ) =>
      _delegate.channelEpg(item, limit);

  Future<XTremeCodeChannelEpg> channelEpgViaStreamId(
    int streamId,
    int? limit,
  ) =>
      _delegate.channelEpgViaStreamId(streamId, limit);

  Future<XTremeCodeChannelEpgTable> channelEpgTable(
    XTremeCodeLiveStreamItem item,
  ) =>
      _delegate.channelEpgTable(item);

  Future<EPG> epg() => _delegate.epg();
}
