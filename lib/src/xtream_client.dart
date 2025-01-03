import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

/// A client for interacting with Xtream Code server.
class XtreamCodeClient {
  /// Constructs an instance of [XtreamCodeClient].
  XtreamCodeClient(
    this._baseUrl,
    this._streamUrl,
    this._movieUrl,
    this._seriesUrl,
    this._http,
  );

  /// The base URL of the Xtream Code server.
  final String _baseUrl;

  /// The _http client for making requests to the server.
  final Client _http;

  /// The base URL for streaming an channel.
  final String _movieUrl;

  /// The base URL for streaming an channel.
  final String _seriesUrl;

  /// The base URL for streaming an channel.
  final String _streamUrl;

  /// The base URL getterof the Xtream Code server.
  String get baseUrl => _baseUrl;

  /// The base URL getter for streaming an channel.
  String streamUrl(int id, List<String> allowedInputFormat) =>
      '$_streamUrl/$id.${allowedInputFormat.firstWhere((format) => format == 'ts', orElse: () => allowedInputFormat.first)}';

  /// The base URL getter for streaming a movie.
  String movieUrl(int id, String containerExtension) =>
      '$_movieUrl/$id.$containerExtension';

  /// The base URL getter for streaming a series.
  String seriesUrl(int id, String containerExtension) =>
      '$_seriesUrl/$id.$containerExtension';

  /// Authenticates the user and retrieves server & user information.
  Future<XTremeCodeGeneralInformation> serverInformation() async {
    final response = await _http.get(
      Uri.parse(
        _baseUrl,
      ),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return XTremeCodeGeneralInformation.fromJson(parsed);
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve GeneralInformation. Server responded with 
        the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves live stream categories.
  Future<List<XTremeCodeCategory>> liveStreamCategories() async {
    const action = 'get_live_categories';
    return _categories(action);
  }

  /// Retrieves VOD categories.
  Future<List<XTremeCodeCategory>> vodCategories() async {
    const action = 'get_vod_categories';
    return _categories(action);
  }

  /// Retrieves series categories.
  Future<List<XTremeCodeCategory>> seriesCategories() async {
    const action = 'get_series_categories';
    return _categories(action);
  }

  /// Retrieves live stream items based on the optional category parameter.
  Future<List<XTremeCodeLiveStreamItem>> livestreamItems({
    XTremeCodeCategory? category,
  }) async {
    var action = 'get_live_streams';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return (parsed is List ? parsed : <dynamic>[])
          .cast<Map<String, dynamic>>()
          .cast<Map<String, dynamic>>()
          .map<XTremeCodeLiveStreamItem>(XTremeCodeLiveStreamItem.fromJson)
          .toList();
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve LiveStreams from action $action.
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves VOD items based on the optional category parameter.
  Future<List<XTremeCodeVodItem>> vodItems({
    XTremeCodeCategory? category,
  }) async {
    var action = 'get_vod_streams';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return (parsed is List ? parsed : <dynamic>[])
          .cast<Map<String, dynamic>>()
          .cast<Map<String, dynamic>>()
          .map<XTremeCodeVodItem>(XTremeCodeVodItem.fromJson)
          .toList();
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve Vods from action $action.
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves information about a specific VOD item.
  Future<XTremeCodeVodInfo> vodInfo(XTremeCodeVodItem vod) async {
    final action = 'get_vod_info&vod_id=${vod.streamId}';
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return XTremeCodeVodInfo.fromJson(parsed);
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve VOD Info from action $action.
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves series items based on the optional category parameter.
  Future<List<XTremeCodeSeriesItem>> seriesItems({
    XTremeCodeCategory? category,
  }) async {
    var action = 'get_series';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return (parsed is List ? parsed : <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map<XTremeCodeSeriesItem>(XTremeCodeSeriesItem.fromJson)
          .toList();
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve Series from action $action.
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves information about a specific series item.
  Future<XTremeCodeSeriesInfo> seriesInfo(XTremeCodeSeriesItem series) async {
    final action = 'get_series_info&series_id=${series.seriesId}';
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return XTremeCodeSeriesInfo.fromJson(parsed);
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve Series Info from action $action.
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves EPG information for a specific live stream item.
  Future<XTremeCodeChannelEpg> channelEpg(
    XTremeCodeLiveStreamItem item,
    int? limit,
  ) async {
    return channelEpgViaStreamId(item.streamId!, limit);
  }

  /// Retrieves EPG information for a specific live stream item.
  Future<XTremeCodeChannelEpg> channelEpgViaStreamId(
    int streamId,
    int? limit,
  ) async {
    var action = 'get_short_epg&stream_id=$streamId';
    if (limit != null) {
      action = '$action&limit=$limit';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return XTremeCodeChannelEpg.fromJson(parsed);
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve EPG from action $action for channel_id $streamId
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves EPG table for a specific live stream item.
  Future<XTremeCodeChannelEpgTable> channelEpgTable(
    XTremeCodeLiveStreamItem item,
  ) async {
    final action = 'get_simple_data_table&stream_id=${item.streamId}';
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return XTremeCodeChannelEpgTable.fromJson(parsed);
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve EPG Table from action $action for channel_id ${item.streamId}
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves the EPG (Electronic Program Guide) data in XMLTV format.
  /// If useLocalFile is true, it reads from the local 'iptv.xml' file
  /// instead of making an API call.
  Future<EPG> epg() async {
    final uri = Uri.parse(_baseUrl.replaceFirst('player_api.php', 'xmltv.php'));
    final response = await _http.get(uri);

    if (response.statusCode == 200) {
      final xmlString = response.body;
      final parser = EpgParser();
      return parser.parse(xmlString);
    } else {
      throw XTreamCodeClientException(
        'Failed to fetch XMLTV data. Server responded with status code ${response.statusCode}.',
      );
    }
  }

  /// Common method for retrieving categories based on the given action.
  Future<List<XTremeCodeCategory>> _categories(String action) async {
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return (parsed is List ? parsed : <dynamic>[])
          .cast<Map<String, dynamic>>()
          .cast<Map<String, dynamic>>()
          .map<XTremeCodeCategory>(XTremeCodeCategory.fromJson)
          .toList();
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve Categories from action $action.
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }
}
