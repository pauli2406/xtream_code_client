/// Represents an exception that occurs when interacting with the Xtream Code 
/// Client.
class XTreamCodeClientException implements Exception {
  /// Creates a new instance of [XTreamCodeClientException].
  ///
  /// The [cause] parameter should describe the reason for the exception.
  XTreamCodeClientException(this.cause);

  /// The cause of the exception.
  final String cause;
}
