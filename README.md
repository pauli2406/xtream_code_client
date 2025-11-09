# XTream Code Client

## Description

This Dart package, named xtream_code_client, provides a client for interacting with the Xtream Codes API. Xtream Codes is an IPTV panel that allows providers to manage their own IPTV service and its customers. It provides a simple and powerful API for managing users, subscriptions, and billing.

The xtream_code_client package provides easy and efficient access to the Xtream Codes API, with features like:

- ✅ **Smart Parser System** - Automatically handles inconsistent API responses (dates, numbers, booleans)
- ✅ **Flexible Format Support** - Works with different server implementations out of the box
- ✅ **Custom Parser Configuration** - Override specific fields when needed
- ✅ **Automatic Error Handling** - Built-in error handling and retries
- ✅ **Platform-Optimized** - Intelligently selects the best HTTP client for your platform
- ✅ **Type-Safe Models** - Comprehensive models for all API data structures

It includes a variety of models for different data structures, such as categories, channel EPGs, general information, live stream items, series info, and more.

This package is designed to work with the Flutter SDK, and it intelligently selects the most suitable HTTP client implementation based on the platform in use, ensuring optimal functionality and performance.

## What are Xtream Codes?

Xtream Codes is an IPTV panel used by providers to manage their IPTV service. It provides a comprehensive API for managing users, subscriptions, and billing. With Xtream Codes, providers can create, manage, and distribute their IPTV channels and VOD content.

## Installation 💻

**❗ In order to start using Xtream Code Client you must have the Flutter SDK installed on your machine.**

Install via `flutter pub add`:

```sh
dart pub add xtream_code_client
```

Or add to your `pubspec.yaml`:

```yaml
dependencies:
  xtream_code_client: ^2.0.0
```

### Upgrading from 1.x

Version 2.0.0 is **100% backward compatible**. See the [Migration Guide](MIGRATION_GUIDE.md) for details.

**Quick upgrade:**
1. Update version to `^2.0.0`
2. Run `flutter pub get`
3. That's it! Your code works immediately with improved parsing.

---

## Usage

### Initialization

Before issuing any request you **must** initialise the library. The
`XtreamCode` class follows the singleton pattern and exposes a single instance
through `XtreamCode.instance`. Calling `XtreamCode.initialize` prepares this
instance and configures the underlying HTTP client.

```dart
import 'package:xtream_code_client/xtream_code_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // With port number
  await XtreamCode.initialize(
    url: 'https://your-server-url',
    port: '8080',
    username: 'your-username',
    password: 'your-password',
  );

  // Or without port number (port is now optional)
  await XtreamCode.initialize(
    url: 'https://your-server-url',
    username: 'your-username',
    password: 'your-password',
  );

  // Optional: Custom parser configuration for specific server formats
  // See "Smart Parser System" section below for more details
  final config = ParserConfig.override(
    dateFieldParsers: {
      'end': DateParser.epochSeconds(),
    },
  );
  await XtreamCode.initialize(
    url: 'https://your-server-url',
    port: '8080',
    username: 'your-username',
    password: 'your-password',
    parserConfig: config,
  );

  // Optional: Custom HTTP client
  await XtreamCode.initialize(
    url: 'https://your-server-url',
    port: '8080',
    username: 'your-username',
    password: 'your-password',
    httpClient: customHttpClient, // Custom HTTP client implementation
  );

  runApp(MyApp());
}

// Access the configured client anywhere in your code
final XtreamCodeClient client = XtreamCode.instance.client;
```

Calling `XtreamCode.instance` without initialising first will throw an
assertion error. When the application is shut down you can optionally call
`XtreamCode.instance.dispose()` to close the underlying HTTP client.

### Basic workflow

Once the client is initialised you can request categories and items from the
server. The typical order of operations is:

1. **Fetch server and user information** via `serverInformation()`.
2. **Load all categories** for live streams, VOD and series.
3. **Fetch all streams/VOD/series items** or limit them to a specific
   category.
4. **Retrieve extra details** like VOD or series info.
5. **Generate playback URLs** using the helper methods.
6. **Access EPG data** for live streams.

```dart
// obtain general server info and user details
final info = await client.serverInformation();

// fetch available categories
final liveCategories = await client.liveStreamCategories();
final vodCategories = await client.vodCategories();
final seriesCategories = await client.seriesCategories();

// load items for the first category of each type
final liveStreams = await client.livestreamItems(
  category: liveCategories.first,
);
final vodItems = await client.vodItems(
  category: vodCategories.first,
);
final seriesItems = await client.seriesItems(
  category: seriesCategories.first,
);

// retrieve additional details
final vodInfo = await client.vodInfo(vodItems.first);
final seriesInfo = await client.seriesInfo(seriesItems.first);

// playback URLs can be created via the helper methods
final firstStreamUrl = client.streamUrl(liveStreams.first.streamId!, ['ts']);

// Electronic Program Guide (EPG)
final epgTable = await client.epg(); // Full EPG in XMLTV format
final channelEpg = await client.channelEpg(liveStreams.first, 10); // EPG for a channel
final channelEpgById = await client.channelEpgViaStreamId(liveStreams.first.streamId!, 5); // EPG by stream ID
final channelTable = await client.channelEpgTable(liveStreams.first); // EPG table
```

### Playback URLs

Use the URL helpers to construct playable links for live streams,
movies and series episodes. You can pass your preferred container
extension. If the item defines one, it will usually work best.

```dart
final streamUrl = client.streamUrl(liveStreams.first.streamId!, ['ts']);
final movieUrl = client.movieUrl(
  vodItems.first.streamId!,
  vodItems.first.containerExtension ?? 'mp4',
);
final episode = seriesInfo.episodes?.values.first.first;
final seriesUrl = episode != null
    ? client.seriesUrl(episode.id!, episode.containerExtension ?? 'ts')
    : null;
```

### Smart Parser System

The Xtream Codes API is notorious for inconsistent data formats across different server implementations. This library includes a **smart parser system** that automatically handles these inconsistencies.

#### Automatic Format Detection (Default)

By default, smart parsers automatically detect and handle:

- **Date/Time Formats:**
  - ISO 8601: `"2024-04-09T01:35:00Z"`
  - Weird formats: `"2024-04-09 01:35:00"`
  - Epoch seconds: `1712619300` or `"1712619300"`
  - Epoch milliseconds: `1712619300000`

- **Number Formats:**
  - Integers as strings: `"123"` → `123`
  - Doubles as strings: `"4.5"` → `4.5`
  - Mixed types handled automatically

- **Boolean Formats:**
  - String: `"1"`, `"true"` → `true`
  - Number: `1` → `true`
  - Boolean: `true` → `true`

**This means your code works out of the box with most servers!**

#### Custom Parser Configuration

If your server uses specific formats or you need to override certain fields:

```dart
import 'package:xtream_code_client/xtream_code_client.dart';

// Option 1: Field-specific overrides
final config = ParserConfig.override(
  dateFieldParsers: {
    'end': DateParser.epochSeconds(),        // Force epoch for 'end'
    'stop_timestamp': DateParser.iso8601(), // Force ISO for this
  },
);

await XtreamCode.initialize(
  url: 'https://your-server-url',
  port: '8080',
  username: 'your-username',
  password: 'your-password',
  parserConfig: config,
);
```

#### Custom Parser for Non-Standard Formats

For truly non-standard formats, create a custom parser:

```dart
final config = ParserConfig.override(
  dateFieldParsers: {
    'end': DateParser.custom((value) {
      // Handle custom format like "2024|04|09|01|35|00"
      if (value is String && value.contains('|')) {
        final parts = value.split('|');
        if (parts.length == 6) {
          try {
            return DateTime(
              int.parse(parts[0]),
              int.parse(parts[1]),
              int.parse(parts[2]),
              int.parse(parts[3]),
              int.parse(parts[4]),
              int.parse(parts[5]),
            );
          } catch (e) {
            return null;
          }
        }
      }
      // Fall back to smart parser for other formats
      return const SmartDateParser().parse(value);
    }),
  },
);
```

#### Available Parser Types

- `DateParser.epochSeconds()` - Only accepts epoch seconds
- `DateParser.iso8601()` - Only accepts ISO 8601 strings
- `DateParser.autoDetect()` - Smart auto-detection (default)
- `DateParser.custom(...)` - Custom parsing function

## API Reference

### Client Methods

The `XtreamCodeClient` provides the following methods:

#### Server & User Information
- `serverInformation()` - Get server and user information

#### Categories
- `liveStreamCategories()` - Get live stream categories
- `vodCategories()` - Get VOD categories
- `seriesCategories()` - Get series categories

#### Items
- `livestreamItems({category?})` - Get live stream items (optionally filtered by category)
- `vodItems({category?})` - Get VOD items (optionally filtered by category)
- `seriesItems({category?})` - Get series items (optionally filtered by category)

#### Detailed Information
- `vodInfo(vodItem)` - Get detailed VOD information
- `seriesInfo(seriesItem)` - Get detailed series information with episodes

#### EPG (Electronic Program Guide)
- `epg()` - Get full EPG in XMLTV format
- `channelEpg(liveStreamItem, limit?)` - Get EPG for a specific channel
- `channelEpgViaStreamId(streamId, limit?)` - Get EPG by stream ID
- `channelEpgTable(liveStreamItem)` - Get EPG table for a channel

#### URL Generation
- `streamUrl(streamId, allowedFormats)` - Generate live stream URL
- `movieUrl(streamId, containerExtension)` - Generate movie/VOD URL
- `seriesUrl(episodeId, containerExtension)` - Generate series episode URL

#### Properties
- `baseUrl` - Get the base URL of the Xtream Code server
- `parserConfig` - Get the parser configuration for this client

### Models

The library includes comprehensive models for all API responses:

- `XTremeCodeCategory` - Category information
- `XTremeCodeLiveStreamItem` - Live stream item
- `XTremeCodeVodItem` - VOD item
- `XTremeCodeVodInfo` - Detailed VOD information
- `XTremeCodeSeriesItem` - Series item
- `XTremeCodeSeriesInfo` - Detailed series information with episodes
- `XTremeCodeChannelEpg` - Channel EPG data
- `XTremeCodeChannelEpgTable` - Channel EPG table
- `XTremeCodeGeneralInformation` - Server and user information
- `XTremeCodeServerInfo` - Server information
- `XTremeCodeUserInfo` - User information
- `EPG` - Full XMLTV EPG data

### Error Handling

All API methods throw `XTreamCodeClientException` when:
- The server responds with a non-200 status code
- Network errors occur
- Invalid data is received

```dart
try {
  final info = await client.serverInformation();
} on XTreamCodeClientException catch (e) {
  print('Error: ${e.cause}');
}
```

### Initialization Options

The `XtreamCode.initialize()` method accepts:

- `url` (required) - Server URL
- `port` (optional) - Server port
- `username` (required) - Authentication username
- `password` (required) - Authentication password
- `httpClient` (optional) - Custom HTTP client implementation
- `debug` (optional) - Enable debug logging (defaults to `kDebugMode`)
- `parserConfig` (optional) - Custom parser configuration

### Resource Management

When your application shuts down, you can dispose the instance:

```dart
await XtreamCode.instance.dispose();
```

This closes the underlying HTTP client and frees up resources.

## Demo

A minimal command line example is available in the [demo](demo/) directory.
It shows how to initialise the library, fetch categories and list the first
stream URL. Run it with:

```bash
dart run demo/demo.dart
```

Feel free to adapt it for your own experiments.

## Troubleshooting

### Parsing Issues

If you encounter issues with date or number parsing:

1. **Enable debug logging** to see what the server is returning:
   ```dart
   await XtreamCode.initialize(
     url: '...',
     port: '...',
     username: '...',
     password: '...',
     debug: true, // Enable debug logging
   );
   ```

2. **Check the raw JSON** - Look at the actual server response format

3. **Use field-specific overrides** if you know the exact format:
   ```dart
   final config = ParserConfig.override(
     dateFieldParsers: {
       'problematic_field': DateParser.epochSeconds(),
     },
   );
   ```

4. **Create a custom parser** for truly non-standard formats

### Common Issues

- **Assertion Error on `XtreamCode.instance`**: Make sure you call `XtreamCode.initialize()` first
- **Date parsing fails**: Check if your server uses a non-standard format and configure accordingly
- **Numbers as strings**: Smart parsers handle this automatically, but you can override if needed
- **Network errors**: Check your internet connection and server URL/credentials
- **HTTP client issues**: The library automatically selects the best HTTP client for your platform, but you can provide a custom one if needed

### iOS Configuration

Many IPTV servers use HTTP instead of HTTPS. iOS requires App Transport Security (ATS) configuration to allow HTTP connections.

For iOS apps, you need to configure `Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

**For production apps**, it's recommended to use domain-specific exceptions instead of allowing all HTTP connections. See the [example project](example/ios/Runner/Info.plist) for a more secure configuration.

## Migration Guide

Upgrading from version 1.x? See the [Migration Guide](MIGRATION_GUIDE.md) for:
- What changed in 2.0.0
- Migration steps (spoiler: none required!)
- New features and how to use them
- Troubleshooting tips

## Legal Disclaimer

This software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

Please note that this package is intended for legal uses only. It is the user's responsibility to ensure that they have the necessary rights and permissions to use the Xtream Codes API and any data accessed through it. The authors of this package are not responsible for any illegal use
