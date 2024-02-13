import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

/// Maximum cache size for the HTTP client.
const _maxCacheSize = 2 * 1024 * 1024;

/// Creates and returns a new [Client] instance based on the platform.
///
/// On Android, it returns a [CronetClient] with a memory cache of size
/// [_maxCacheSize].
/// On iOS and macOS, it returns a [CupertinoClient] with a memory cache of size
/// [_maxCacheSize].
/// On other platforms, it returns an [IOClient].
Client httpClient() {
  if (Platform.isAndroid) {
    final engine = CronetEngine.build(
      cacheMode: CacheMode.memory,
      cacheMaxSize: _maxCacheSize,
    );
    return CronetClient.fromCronetEngine(engine);
  }
  if (Platform.isIOS || Platform.isMacOS) {
    final config = URLSessionConfiguration.ephemeralSessionConfiguration()
      ..cache = URLCache.withCapacity(memoryCapacity: _maxCacheSize);
    return CupertinoClient.fromSessionConfiguration(config);
  }
  return IOClient(HttpClient());
}
