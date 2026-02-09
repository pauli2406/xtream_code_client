import 'package:http/http.dart';
import 'package:xtream_code_client/src/exception/xtream_code_client_exception.dart';
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
import 'package:xtream_code_client/src/v2/client/xtream_client.dart';
import 'package:xtream_code_client/src/v2/compat/legacy_model_mapper.dart';
import 'package:xtream_code_client/src/v2/core/parser_options.dart';

/// Backwards-compatible adapter that keeps the legacy method signatures.
class LegacyXtreamCodeClient {
  LegacyXtreamCodeClient({
    required String baseUrl,
    required String streamUrl,
    required String movieUrl,
    required String seriesUrl,
    required Client httpClient,
    ParserOptions parserOptions = const ParserOptions(),
  }) : _client = XtreamClient.fromResolvedUrls(
          baseUrl: baseUrl,
          streamUrl: streamUrl,
          movieUrl: movieUrl,
          seriesUrl: seriesUrl,
          httpClient: httpClient,
          parserOptions: parserOptions,
        );

  final XtreamClient _client;

  String get baseUrl => _client.baseUrl;

  String streamUrl(int id, List<String> allowedInputFormat) =>
      _client.streamUrl(id, allowedInputFormat);

  String movieUrl(int id, String containerExtension) =>
      _client.movieUrl(id, containerExtension);

  String seriesUrl(int id, String containerExtension) =>
      _client.seriesUrl(id, containerExtension);

  Future<XTremeCodeGeneralInformation> serverInformation() async {
    try {
      final data = await _client.serverInformationData();
      return LegacyModelMapper.toLegacyGeneralInformation(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<List<XTremeCodeCategory>> liveStreamCategories() async {
    try {
      final data = await _client.liveStreamCategoriesData();
      return LegacyModelMapper.toLegacyCategoryList(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<List<XTremeCodeCategory>> vodCategories() async {
    try {
      final data = await _client.vodCategoriesData();
      return LegacyModelMapper.toLegacyCategoryList(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<List<XTremeCodeCategory>> seriesCategories() async {
    try {
      final data = await _client.seriesCategoriesData();
      return LegacyModelMapper.toLegacyCategoryList(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<List<XTremeCodeLiveStreamItem>> livestreamItems({
    XTremeCodeCategory? category,
  }) async {
    try {
      final data = await _client.liveStreamItemsData(
        category: category == null
            ? null
            : LegacyModelMapper.toCanonicalCategory(category),
      );
      return LegacyModelMapper.toLegacyLiveStreamItemList(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<List<XTremeCodeVodItem>> vodItems({
    XTremeCodeCategory? category,
  }) async {
    try {
      final data = await _client.vodItemsData(
        category: category == null
            ? null
            : LegacyModelMapper.toCanonicalCategory(category),
      );
      return LegacyModelMapper.toLegacyVodItemList(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<XTremeCodeVodInfo> vodInfo(XTremeCodeVodItem vod) async {
    try {
      final data =
          await _client.vodInfoData(LegacyModelMapper.toCanonicalVodItem(vod));
      return LegacyModelMapper.toLegacyVodInfo(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<List<XTremeCodeSeriesItem>> seriesItems({
    XTremeCodeCategory? category,
  }) async {
    try {
      final data = await _client.seriesItemsData(
        category: category == null
            ? null
            : LegacyModelMapper.toCanonicalCategory(category),
      );
      return LegacyModelMapper.toLegacySeriesItemList(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<XTremeCodeSeriesInfo> seriesInfo(XTremeCodeSeriesItem series) async {
    try {
      final data = await _client.seriesInfoData(
        LegacyModelMapper.toCanonicalSeriesItem(series),
      );
      return LegacyModelMapper.toLegacySeriesInfo(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<XTremeCodeChannelEpg> channelEpg(
    XTremeCodeLiveStreamItem item,
    int? limit,
  ) async {
    try {
      final data = await _client.channelEpgData(
        LegacyModelMapper.toCanonicalLiveStreamItem(item),
        limit,
      );
      return LegacyModelMapper.toLegacyChannelEpg(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<XTremeCodeChannelEpg> channelEpgViaStreamId(
    int streamId,
    int? limit,
  ) async {
    try {
      final data = await _client.channelEpgViaStreamIdData(streamId, limit);
      return LegacyModelMapper.toLegacyChannelEpg(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<XTremeCodeChannelEpgTable> channelEpgTable(
    XTremeCodeLiveStreamItem item,
  ) async {
    try {
      final data = await _client.channelEpgTableData(
        LegacyModelMapper.toCanonicalLiveStreamItem(item),
      );
      return LegacyModelMapper.toLegacyChannelEpgTable(data);
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  Future<EPG> epg() async {
    try {
      return await _client.epgData();
    } catch (error) {
      throw XTreamCodeClientException(error.toString());
    }
  }

  void close() {
    _client.close();
  }
}
