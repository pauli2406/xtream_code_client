/// Endpoint paths and default query parameters used by the v2 client.
///
/// All path values are relative to the provided base URL.
class EndpointConfig {
  /// Creates endpoint configuration.
  const EndpointConfig({
    this.playerApiPath = 'player_api.php',
    this.xmltvPath = 'xmltv.php',
    this.playlistPath = 'get.php',
    this.defaultQueryParameters = const <String, String>{},
  });

  /// Path used for action-based API requests.
  final String playerApiPath;

  /// Path used by full EPG and lightweight EPG XML requests.
  final String xmltvPath;

  /// Path used for playlist URL generation (`m3uPlaylistUri/Url`).
  final String playlistPath;

  /// Query parameters merged into generated API and playlist URLs.
  final Map<String, String> defaultQueryParameters;
}
