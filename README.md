# XTream Code Client

## Description

This Dart package, named xtream_code_client, provides a client for interacting with the Xtream Codes API. Xtream Codes is an IPTV panel that allows providers to manage their own IPTV service and its customers. It provides a simple and powerful API for managing users, subscriptions, and billing.

The xtream_code_client package provides easy and efficient access to the Xtream Codes API, with features like automatic retries and error handling. It includes a variety of models for different data structures, such as categories, channel EPGs, general information, live stream items, series info, and more.

This package is designed to work with the Flutter SDK, and it intelligently selects the most suitable HTTP client implementation based on the platform in use, ensuring optimal functionality and performance.

## What are Xtream Codes?

Xtream Codes is an IPTV panel used by providers to manage their IPTV service. It provides a comprehensive API for managing users, subscriptions, and billing. With Xtream Codes, providers can create, manage, and distribute their IPTV channels and VOD content.

## Installation 💻

**❗ In order to start using Xtream Code Client you must have the Flutter SDK installed on your machine.**

Install via `flutter pub add`:

```sh
dart pub add xtream_code_client
```

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
final epgTable = await client.epg();
final channelEpg = await client.channelEpg(liveStreams.first, 10);
final channelTable = await client.channelEpgTable(liveStreams.first);
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

## Demo

A minimal command line example is available in the [demo](demo/) directory.
It shows how to initialise the library, fetch categories and list the first
stream URL. Run it with:

```bash
dart run demo/demo.dart
```

Feel free to adapt it for your own experiments.

## Legal Disclaimer

This software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

Please note that this package is intended for legal uses only. It is the user's responsibility to ensure that they have the necessary rights and permissions to use the Xtream Codes API and any data accessed through it. The authors of this package are not responsible for any illegal use
