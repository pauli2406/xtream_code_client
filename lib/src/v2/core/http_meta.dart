/// HTTP metadata attached to API responses.
class HttpMeta {
  const HttpMeta({
    required this.requestUri,
    required this.statusCode,
    required this.headers,
    required this.duration,
  });

  final Uri requestUri;
  final int statusCode;
  final Map<String, String> headers;
  final Duration duration;
}
