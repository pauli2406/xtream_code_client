import 'package:fetch_client/fetch_client.dart';
import 'package:http/http.dart';

/// Creates and returns a new [Client] instance with CORS (Cross-Origin Resource
/// Sharing) enabled.
///
/// This function is typically used when making HTTP requests in a web
/// environment.
Client httpClient() => FetchClient(mode: RequestMode.cors);
