/// Thrown when an HTTP request fails or returns a non-success status code.
class RequestException implements Exception {
  const RequestException(this.message);

  final String message;

  @override
  String toString() => 'RequestException($message)';
}
