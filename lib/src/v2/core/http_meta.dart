/// Request metadata attached to each API result response.
class HttpMeta {
  /// Creates HTTP metadata.
  const HttpMeta({
    required this.requestUri,
    required this.statusCode,
    required this.headers,
    required this.duration,
  });

  /// Fully resolved request URI used by the client.
  final Uri requestUri;

  /// HTTP response status code.
  final int statusCode;

  /// Response headers returned by the server.
  final Map<String, String> headers;

  /// End-to-end request duration measured by the client.
  final Duration duration;
}
