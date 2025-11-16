import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

/// Top-level function for parsing EPG XML in an isolate
/// Must be top-level or static to be used with compute()
EPG _parseEpgXml(String xmlString) {
  final parser = EpgParser();
  return parser.parse(xmlString);
}

/// Top-level function for parsing categories JSON in an isolate
List<XTremeCodeCategory> _parseCategories(String jsonString) {
  final parsed = json.decode(jsonString);
  return (parsed is List ? parsed : <dynamic>[])
      .cast<Map<String, dynamic>>()
      .map<XTremeCodeCategory>(XTremeCodeCategory.fromJson)
      .toList();
}

/// Top-level function for parsing live streams JSON in an isolate
List<XTremeCodeLiveStreamItem> _parseLiveStreams(String jsonString) {
  final parsed = json.decode(jsonString);
  return (parsed is List ? parsed : <dynamic>[])
      .cast<Map<String, dynamic>>()
      .map<XTremeCodeLiveStreamItem>(XTremeCodeLiveStreamItem.fromJson)
      .toList();
}

/// Top-level function for parsing VOD items JSON in an isolate
List<XTremeCodeVodItem> _parseVodItems(String jsonString) {
  final parsed = json.decode(jsonString);
  return (parsed is List ? parsed : <dynamic>[])
      .cast<Map<String, dynamic>>()
      .map<XTremeCodeVodItem>(XTremeCodeVodItem.fromJson)
      .toList();
}

/// Top-level function for parsing series items JSON in an isolate
List<XTremeCodeSeriesItem> _parseSeriesItems(String jsonString) {
  final parsed = json.decode(jsonString);
  return (parsed is List ? parsed : <dynamic>[])
      .cast<Map<String, dynamic>>()
      .map<XTremeCodeSeriesItem>(XTremeCodeSeriesItem.fromJson)
      .toList();
}

/// A client for interacting with Xtream Code server.
class XtreamCodeClient {
  /// Constructs an instance of [XtreamCodeClient].
  XtreamCodeClient(
    this._baseUrl,
    this._streamUrl,
    this._streamPlaylistM3uUrl,
    this._movieUrl,
    this._seriesUrl,
    this._http,
    this._path,
  );

  /// The base URL of the Xtream Code server.
  final String _baseUrl;

  /// The path to the Xtream Code API endpoint.
  /// Defaults to 'player_api.php'.
  final String _path;

  /// The _http client for making requests to the server.
  final Client _http;

  /// Base URL for streaming a movie.
  final String _movieUrl;

  /// Base URL for streaming a series.
  final String _seriesUrl;

  /// Base URL for streaming a channel.
  final String _streamUrl;

  /// Base URL for streaming a channel's M3U playlist.
  final String _streamPlaylistM3uUrl;

  /// The base URL getter of the Xtream Code server.
  String get baseUrl => _baseUrl;

  /// The base URL getter for streaming a channel.
  String streamUrl(int id, List<String> allowedInputFormat) =>
      '$_streamUrl/$id.${allowedInputFormat.firstWhere((format) => format == 'ts', orElse: () => allowedInputFormat.first)}';

  String liveStreamM3uPlaylistUrl(int id) {
    final url = '$_streamPlaylistM3uUrl/$id.m3u8';
    return url;
  }

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
  /// Uses compute() to parse JSON in a background isolate for better performance.
  Future<List<XTremeCodeLiveStreamItem>> livestreamItems({
    XTremeCodeCategory? category,
  }) async {
    var action = 'get_live_streams';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      // Parse JSON in background isolate to prevent UI freezing
      return compute(_parseLiveStreams, response.body);
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
  /// Uses compute() to parse JSON in a background isolate for better performance.
  Future<List<XTremeCodeVodItem>> vodItems({
    XTremeCodeCategory? category,
  }) async {
    var action = 'get_vod_streams';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      // Parse JSON in background isolate to prevent UI freezing
      return compute(_parseVodItems, response.body);
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
    return vodInfoByStreamId(vod.streamId?.toString() ?? '');
  }

  /// Retrieves information about a specific VOD item.
  Future<XTremeCodeVodInfo> vodInfoByStreamId(String streamId) async {
    final action = 'get_vod_info&vod_id=$streamId';
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
  /// Uses compute() to parse JSON in a background isolate for better performance.
  Future<List<XTremeCodeSeriesItem>> seriesItems({
    XTremeCodeCategory? category,
  }) async {
    var action = 'get_series';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      // Parse JSON in background isolate to prevent UI freezing
      return compute(_parseSeriesItems, response.body);
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
    return seriesInfoById(series.seriesId.toString());
  }

  /// Retrieves information about a specific series item by its ID.
  Future<XTremeCodeSeriesInfo> seriesInfoById(String seriesId) async {
    final action = 'get_series_info&series_id=$seriesId';
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
  ///
  /// Uses compute() to parse the XML in a background isolate to prevent UI freezing
  /// when processing large EPG data (200k+ programmes).
  Future<EPG> epg() async {
    final uri = Uri.parse(_baseUrl.replaceFirst(_path, 'xmltv.php'));
    final response = await _http.get(uri);

    if (response.statusCode == 200) {
      final xmlString = response.body;

      // Parse XML in background isolate to prevent UI freezing
      // This is critical for large EPG files with 200k+ programmes
      return compute(_parseEpgXml, xmlString);
    } else {
      throw XTreamCodeClientException(
        'Failed to fetch XMLTV data. Server responded with status code ${response.statusCode}.',
      );
    }
  }

  /// Common method for retrieving categories based on the given action.
  /// Uses compute() to parse JSON in a background isolate for better performance.
  Future<List<XTremeCodeCategory>> _categories(String action) async {
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      // Parse JSON in background isolate to prevent UI freezing
      return compute(_parseCategories, response.body);
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
