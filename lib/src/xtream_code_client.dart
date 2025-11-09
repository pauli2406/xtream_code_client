import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:xtream_code_client/src/http/http_client_factory.dart'
    if (dart.library.js_interop) 'package:xtream_code_client/src/http/http_client_factory_web.dart'
    as http_factory;
import 'package:xtream_code_client/src/parser/parser_config.dart';
import 'package:xtream_code_client/src/xtream_client.dart';

/// {@template xtream_code_client}
/// A WebClient to access a XTream Code API
///
/// It must be initialized before used, otherwise an error is thrown.
///
/// ```dart
/// await XtreamCode.initialize(...)
/// ```
///
/// Use it:
///
/// ```dart
/// final instance = XtreamCode.instance;
/// ```
///
/// {@endtemplate}
class XtreamCode {
  /// {@macro xtream_code_client}

  XtreamCode._();

  /// Gets the current XtreamCode instance.
  ///
  /// An [AssertionError] is thrown if XtreamCode isn't initialized yet.
  /// Call [XtreamCode.initialize] to initialize it.
  static XtreamCode get instance {
    assert(
      _instance._initialized,
      '''
      You must initialize the XtreamCode instance before calling
      XtreamCode.instance
      ''',
    );
    return _instance;
  }

  /// Initialize the current XtreamCode instance
  ///
  /// This must be called only once. If called more than once, an
  /// [AssertionError] is thrown
  ///
  /// [url] can be found on your Xtream Codes server.
  /// [port] is optional. If not provided, no port will be appended to URLs.
  ///
  /// [username] and [password]
  ///
  /// By default the library will try to use the most efficient http client
  /// implementation based on the current platform.
  /// This behaviour can be overwritten by passing a Custom Http Client
  /// [httpClient] implementation.
  ///
  static Future<XtreamCode> initialize({
    required String url,
    String? port,
    required String username,
    required String password,
    Client? httpClient,
    bool? debug,
    ParserConfig? parserConfig,
  }) async {
    assert(
      !_instance._initialized,
      'This instance is already initialized',
    );

    _instance
      .._init(
        url,
        port,
        username,
        password,
        httpClient,
        parserConfig,
      )
      .._debugEnable = debug ?? kDebugMode
      .._log('***** XtreamCode init completed $_instance');

    return _instance;
  }

  static final XtreamCode _instance = XtreamCode._();

  bool _initialized = false;
  bool _debugEnable = false;

  /// The XtreamCode client for this instance
  ///
  /// Throws an error if [XtreamCode.initialize] was not called.
  late XtreamCodeClient client;

  late Client? _httpClient;

  /// Dispose the instance to free up resources.
  Future<void> dispose() async {
    _httpClient?.close();
    _httpClient = null;
    _initialized = false;
  }

  void _init(
    String url,
    String? port,
    String username,
    String password,
    Client? httpClient,
    ParserConfig? parserConfig,
  ) {
    _httpClient = httpClient ?? http_factory.httpClient();
    client = XtreamCodeClient(
      _createBaseUrl(url, port, username, password),
      _createStreamUrl(url, port, username, password),
      _createMovieUrl(url, port, username, password),
      _createSeriesUrl(url, port, username, password),
      _httpClient!,
      parserConfig,
    );
    _initialized = true;
  }

  void _log(String msg, [StackTrace? stackTrace]) {
    if (_debugEnable) {
      debugPrint(msg);
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  String _createBaseUrl(
    String url,
    String? port,
    String username,
    String password,
  ) {
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    final uri =
        '$url$portPart/player_api.php?username=$username&password=$password';
    assert(
      Uri.parse(uri).isAbsolute,
      '''
      The provided combination of url, port, username and password is not a 
      valid uri
      ''',
    );
    return uri;
  }

  String _createStreamUrl(
    String url,
    String? port,
    String username,
    String password,
  ) {
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    final uri = '$url$portPart/$username/$password';
    assert(
      Uri.parse(uri).isAbsolute,
      '''
      The provided combination of url, port, username and password is not a 
      valid uri
      ''',
    );
    return uri;
  }

  String _createMovieUrl(
    String url,
    String? port,
    String username,
    String password,
  ) {
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    final uri = '$url$portPart/movie/$username/$password';
    assert(
      Uri.parse(uri).isAbsolute,
      '''
      The provided combination of url, port, username and password is not a 
      valid uri
      ''',
    );
    return uri;
  }

  String _createSeriesUrl(
    String url,
    String? port,
    String username,
    String password,
  ) {
    final portPart = (port != null && port.isNotEmpty) ? ':$port' : '';
    final uri = '$url$portPart/series/$username/$password';
    assert(
      Uri.parse(uri).isAbsolute,
      '''
      The provided combination of url, port, username and password is not a 
      valid uri
      ''',
    );
    return uri;
  }
}
