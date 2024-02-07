import 'dart:convert';

import 'package:http/http.dart';
import 'package:xtream_code_client/src/exception/xtream_code_client_exception.dart';
import 'package:xtream_code_client/src/model/categories.dart';
import 'package:xtream_code_client/src/model/category.dart';
import 'package:xtream_code_client/src/model/channel_epg.dart';
import 'package:xtream_code_client/src/model/channel_epg_table.dart';
import 'package:xtream_code_client/src/model/live_stream_items.dart';
import 'package:xtream_code_client/src/model/login_info.dart';
import 'package:xtream_code_client/src/model/series_info.dart';
import 'package:xtream_code_client/src/model/series_items.dart';
import 'package:xtream_code_client/src/model/vod_items.dart';

/// A client for interacting with Xtream Code server.
class XtreamCodeClient {
  /// Constructs an instance of [XtreamCodeClient].
  XtreamCodeClient(
    this._baseUrl,
    this._http,
  );

  /// The base URL of the Xtream Code server.
  final String _baseUrl;

  /// The base URL getterof the Xtream Code server.
  String get baseUrl => _baseUrl;

  /// The _http client for making requests to the server.
  final Client _http;

  /// Authenticates the user and retrieves login information.
  Future<LoginInfo> login() async {
    final response = await _http.get(Uri.parse(
      _baseUrl,
    ));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return LoginInfo.fromJson(parsed);
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve LoginInfo. Server responded with 
        the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves live stream categories.
  Future<Categories> liveStreamCategories() async {
    const action = 'get_live_categories';
    return _categories(action);
  }

  /// Retrieves VOD categories.
  Future<Categories> vodCategories() async {
    const action = 'get_vod_categories';
    return _categories(action);
  }

  /// Retrieves series categories.
  Future<Categories> seriesCategories() async {
    const action = 'get_series_categories';
    return _categories(action);
  }

  /// Retrieves live stream items based on the optional category parameter.
  Future<LiveStreamItems> livestreamItems(Category? category) async {
    var action = 'get_live_streams';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return LiveStreamItems.fromJson(parsed);
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
  Future<VodItems> vodItems(Category? category) async {
    var action = 'get_vod_streams';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return VodItems.fromJson(parsed);
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
  Future<SeriesInfo> vodInfo(VodItem series) async {
    final action = 'get_vod_info&vod_id=${series.streamId}';
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return SeriesInfo.fromJson(parsed);
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
  Future<SeriesItems> seriesItems(Category? category) async {
    var action = 'get_series';
    if (category != null) {
      action = '$action&category_id=${category.categoryId}';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return SeriesItems.fromJson(parsed);
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
  Future<SeriesInfo> seriesInfo(SeriesItem series) async {
    final action = 'get_series_info&series_id=${series.seriesId}';
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return SeriesInfo.fromJson(parsed);
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
  Future<ChannelEpg> channelEpg(LiveStreamItem item, int? limit) async {
    var action = 'get_short_epg&stream_id=${item.streamId}';
    if (limit != null) {
      action = '$action&limit=$limit';
    }
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return ChannelEpg.fromJson(parsed);
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve EPG from action $action for channel_id ${item.streamId}
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Retrieves EPG table for a specific live stream item.
  Future<ChannelEpgTable> channelEpgTable(LiveStreamItem item) async {
    final action = 'get_simple_data_table&stream_id=${item.streamId}';
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return ChannelEpgTable.fromJson(parsed);
    } else {
      throw XTreamCodeClientException(
        '''
        Failed to retrieve EPG Table from action $action for channel_id ${item.streamId}
        Server responded with the error code ${response.statusCode}.
        ''',
      );
    }
  }

  /// Common method for retrieving categories based on the given action.
  Future<Categories> _categories(String action) async {
    final response = await _http.get(Uri.parse('$_baseUrl&action=$action'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      return Categories.fromJson(parsed);
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
