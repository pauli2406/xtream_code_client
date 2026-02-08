# Xtream Code Client

A Dart client for Xtream-compatible IPTV APIs.

Version `2.x` is the recommended API surface. It adds resilient parsing, structured parse warnings, adaptive background parsing, endpoint configurability, and compatibility wrappers for legacy v1-style APIs.

## Documentation

- [Docs index](docs/index.md)
- [Getting started](docs/getting-started.md)
- [Configuration](docs/configuration.md)
- [Parsing modes](docs/parsing-modes.md)
- [Performance tuning](docs/performance-tuning.md)
- [Migration v1 to v2](docs/migration-v1-to-v2.md)
- [Legacy APIs](docs/legacy-apis.md)
- [Troubleshooting](docs/troubleshooting.md)

## Installation

```bash
dart pub add xtream_code_client
```

## Quick Start (v2)

```dart
import 'package:xtream_code_client/xtream_code_client.dart';

Future<void> main() async {
  final client = XtreamClient(
    url: 'https://your-server-url',
    username: 'your-username',
    password: 'your-password',
  );

  final categories = await client.liveStreamCategories();
  final streams = await client.liveStreamItems(
    category: categories.data.isEmpty ? null : categories.data.first,
  );

  print('streams: ${streams.data.length}');
  print('warnings: ${streams.warnings.length}');

  client.close();
}
```

## `ApiResult<T>`

All v2 endpoint methods return `Future<ApiResult<T>>`:

- `data`: parsed domain object(s)
- `warnings`: non-fatal parse diagnostics from lenient mode
- `meta`: request metadata (`requestUri`, `statusCode`, headers, duration)

Each endpoint also has a `*Data()` helper that returns only `T` (for example `liveStreamItemsData()`).

## Parse Modes and Warnings

- Default mode is `ParseMode.lenient`.
- Lenient mode avoids crashes on malformed payload fields and records `ParseWarning` entries.
- `ParseMode.strict` turns parse mismatches into parse exceptions.

```dart
final client = XtreamClient(
  url: 'https://your-server-url',
  username: 'your-username',
  password: 'your-password',
  parserOptions: const ParserOptions.strict(),
);
```

See [parsing-modes.md](docs/parsing-modes.md) for behavior details and warning interpretation.

## EPG APIs

- `epg()`: full XMLTV model (`EPG`) for complete metadata.
- `epgLite()`: lightweight `EpgLite` model optimized for speed and lower memory.

## Playlist URL Helpers

Use v2 helpers to build playlist URLs safely:

```dart
final uri = client.m3uPlaylistUri(
  type: 'm3u_plus',
  output: 'ts',
  extraQuery: {'timezone': 'UTC'},
);

final url = client.m3uPlaylistUrl();
```

## Choosing Isolate Thresholds

In `BackgroundParsingMode.auto` (default), payloads are offloaded when they are at or above configured byte thresholds:

- `jsonIsolateMinBytes = 131072` (128 KiB)
- `xmlIsolateMinBytes = 98304` (96 KiB)

Practical guidance:

- Lower thresholds when UI jank appears while parsing.
- Raise thresholds when isolate overhead dominates throughput.
- Keep XML threshold lower than JSON because XML parsing is usually heavier.

See [performance-tuning.md](docs/performance-tuning.md) for presets, benchmark workflow, and tuning strategy.

## Endpoint Configuration

You can customize API paths and apply shared query parameters via `EndpointConfig`.

```dart
final client = XtreamClient(
  url: 'https://your-server-url',
  username: 'your-username',
  password: 'your-password',
  endpointConfig: const EndpointConfig(
    playerApiPath: 'player_api.php',
    xmltvPath: 'xmltv.php',
    playlistPath: 'get.php',
    defaultQueryParameters: {'token': 'abc'},
  ),
);
```

See [configuration.md](docs/configuration.md) for URL construction behavior and examples.

## Legacy APIs

Legacy classes (`XtreamCode`, `XtreamCodeClient`, and `XTremeCode*` models) are still exported for migration compatibility and are deprecated. For migration steps, see [migration-v1-to-v2.md](docs/migration-v1-to-v2.md).

## Examples

- Package example: [example/README.md](example/README.md)
- Demo source: [example/lib/demo/demo.dart](example/lib/demo/demo.dart)

## Legal Disclaimer

This software is provided "as is", without warranty of any kind. You are responsible for ensuring that your use of any Xtream-compatible API and content is legal in your jurisdiction and authorized by the relevant rights holders.
