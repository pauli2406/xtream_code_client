# Configuration

## `XtreamClient` Constructor

```dart
final client = XtreamClient(
  url: 'https://provider.example',
  port: '8080',
  username: 'alice',
  password: 'secret',
  httpClient: null,
  parserOptions: const ParserOptions(),
  endpointConfig: const EndpointConfig(),
  parseExecutor: const DefaultParseExecutor(),
);
```

## `EndpointConfig`

`EndpointConfig` customizes Xtream endpoint paths and default query params.

Defaults:

- `playerApiPath = 'player_api.php'`
- `xmltvPath = 'xmltv.php'`
- `playlistPath = 'get.php'`
- `defaultQueryParameters = {}`

Example:

```dart
final client = XtreamClient(
  url: 'https://provider.example',
  username: 'alice',
  password: 'secret',
  endpointConfig: const EndpointConfig(
    playerApiPath: 'custom/player_api.php',
    xmltvPath: 'custom/xmltv.php',
    playlistPath: 'custom/get.php',
    defaultQueryParameters: {'token': 'signed-token'},
  ),
);
```

`defaultQueryParameters` are merged into generated player/XMLTV/playlist query params. `username` and `password` are always included.

## URL Helpers

### Stream/Movie/Series URLs

- `streamUrl(int id, List<String> allowedInputFormat)`
- `movieUrl(int id, String containerExtension)`
- `seriesUrl(int id, String containerExtension)`

### Playlist URLs

- `Uri m3uPlaylistUri({String type = 'm3u_plus', String output = 'ts', Map<String, String> extraQuery = const {}})`
- `String m3uPlaylistUrl({String type = 'm3u_plus', String output = 'ts', Map<String, String> extraQuery = const {}})`

Example:

```dart
final playlist = client.m3uPlaylistUri(
  type: 'm3u_plus',
  output: 'm3u8',
  extraQuery: {'timezone': 'UTC'},
);
```

## Using Resolved URLs Directly

`XtreamClient.fromResolvedUrls` is available when you already have fully constructed endpoints.

```dart
final client = XtreamClient.fromResolvedUrls(
  baseUrl: 'https://provider.example/player_api.php?username=u&password=p',
  streamUrl: 'https://provider.example/u/p',
  movieUrl: 'https://provider.example/movie/u/p',
  seriesUrl: 'https://provider.example/series/u/p',
);
```

When using this constructor with custom `EndpointConfig`, XMLTV and playlist URLs are derived from the resolved base URL root path.

## Path and Query Behavior

- Leading slashes in configured endpoint paths are normalized.
- Path joining is segment-safe (avoids malformed double slashes).
- Query params are merged in this order: endpoint defaults, required auth, per-method extras.
