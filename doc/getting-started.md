# Getting Started

## Install

```bash
dart pub add xtream_code_client
```

## Create a v2 Client

```dart
import 'package:xtream_code_client/xtream_code_client.dart';

Future<void> main() async {
  final client = XtreamClient(
    url: 'https://your-server-url',
    username: 'your-username',
    password: 'your-password',
  );

  try {
    final info = await client.serverInformation();
    print(info.data.userInfo.username);

    final categories = await client.liveStreamCategories();
    final firstCategory =
        categories.data.isEmpty ? null : categories.data.first;

    final streams = await client.liveStreamItems(category: firstCategory);
    print('stream count: ${streams.data.length}');
    print('parse warnings: ${streams.warnings.length}');
  } finally {
    client.close();
  }
}
```

## Understanding `ApiResult<T>`

Every v2 endpoint call returns `Future<ApiResult<T>>`:

- `data`: parsed response model(s)
- `warnings`: parsing diagnostics for malformed or inconsistent source data
- `meta`: request details (`requestUri`, `statusCode`, headers, request duration)

For convenience, each endpoint also has a `*Data()` method that returns only `data`.

Example:

```dart
Future<void> compareResults(XtreamClient client) async {
  final result = await client.vodItems();
  final items = result.data;

  final onlyData = await client.vodItemsData();
  assert(items.length == onlyData.length);
}
```

## Parse Modes

Default mode is lenient:

```dart
const parserOptions = ParserOptions();
```

Strict mode:

```dart
const parserOptions = ParserOptions.strict();
```

- Lenient mode keeps parsing when possible and appends warnings.
- Strict mode throws when a required conversion fails.

See [parsing-modes.md](parsing-modes.md).

## EPG Choices

- Use `epg()` for full XMLTV data (`EPG`).
- Use `epgLite()` for a smaller, faster representation (`EpgLite`).

## Next

- Tune endpoint paths and URL helpers: [configuration.md](configuration.md)
- Tune background parsing thresholds: [performance-tuning.md](performance-tuning.md)
- Migrate from legacy APIs: [migration-v1-to-v2.md](migration-v1-to-v2.md)
