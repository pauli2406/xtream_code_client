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

## Useage

Instantiate the XtreamCodeClient:

```dart
import 'package:xtream_code_client/xtream_code_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await XtreamCode.initialize(
    baseUrl: 'https://your-xtream-codes-api-url',
    username: 'your-username',
    password: 'your-password',
  );

  runApp(MyApp());
}

// It's handy to then extract the XtreamCode http client in a variable for later uses
final client = XtreamCode.instance.client;
```

Now you can use the client to interact with the Xtream Codes API.

### Functiality

```dart
// Instantiate the XtreamCodeClient
var client = XtreamCodeClient(baseUrl, streamUrl, http);

// Call serverInformation
var serverInfo = await client.serverInformation();

// Call liveStreamCategories
var liveStreamCategories = await client.liveStreamCategories();

// Call vodCategories
var vodCategories = await client.vodCategories();

// Call seriesCategories
var seriesCategories = await client.seriesCategories();

// Call livestreamItems with a category
var liveStreamItems = await client.livestreamItems(category: liveStreamCategories.first);

// Call vodItems with a category
var vodItems = await client.vodItems(category: vodCategories.first);

// Call vodInfo with a VOD item
var vodInfo = await client.vodInfo(vodItems.first);

// Call seriesItems with a category
var seriesItems = await client.seriesItems(category: seriesCategories.first);

// Call seriesInfo with a series item
var seriesInfo = await client.seriesInfo(seriesItems.first);

// Call channelEpg with a live stream item and a limit
var channelEpg = await client.channelEpg(liveStreamItems.first, 10);

// Call channelEpgTable with a live stream item
var channelEpgTable = await client.channelEpgTable(liveStreamItems.first);
```

## Legal Disclaimer

This software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

Please note that this package is intended for legal uses only. It is the user's responsibility to ensure that they have the necessary rights and permissions to use the Xtream Codes API and any data accessed through it. The authors of this package are not responsible for any illegal use.