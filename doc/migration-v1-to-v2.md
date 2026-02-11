# Migration: v1 to v2

Version `2.x` keeps legacy APIs for compatibility, but the recommended API is `XtreamClient`.

## High-level Changes

- v1-style singleton (`XtreamCode`) becomes optional; v2 favors explicit `XtreamClient` instances.
- Methods now return `ApiResult<T>` (plus `*Data()` helpers).
- Parsing is resilient by default with `ParseWarning` diagnostics.
- Date/time parsing is normalized to UTC in v2 models.

## Constructor Migration

### Legacy

```dart
Future<void> createLegacyClient() async {
  await XtreamCode.initialize(
    url: 'https://provider.example',
    port: '8080',
    username: 'u',
    password: 'p',
  );

  final legacy = XtreamCode.instance.client;
  print(legacy.baseUrl);
}
```

### v2

```dart
final client = XtreamClient(
  url: 'https://provider.example',
  port: '8080',
  username: 'u',
  password: 'p',
);
```

## Method Mapping

- `serverInformation()` -> `serverInformation()` / `serverInformationData()`
- `liveStreamCategories()` -> `liveStreamCategories()` / `liveStreamCategoriesData()`
- `vodCategories()` -> `vodCategories()` / `vodCategoriesData()`
- `seriesCategories()` -> `seriesCategories()` / `seriesCategoriesData()`
- `livestreamItems()` -> `liveStreamItems()` / `liveStreamItemsData()`
- `vodItems()` -> `vodItems()` / `vodItemsData()`
- `vodInfo()` -> `vodInfo()` / `vodInfoData()`
- `seriesItems()` -> `seriesItems()` / `seriesItemsData()`
- `seriesInfo()` -> `seriesInfo()` / `seriesInfoData()`
- `channelEpg()` -> `channelEpg()` / `channelEpgData()`
- `channelEpgViaStreamId()` -> `channelEpgViaStreamId()` / `channelEpgViaStreamIdData()`
- `channelEpgTable()` -> `channelEpgTable()` / `channelEpgTableData()`
- `epg()` -> `epg()` / `epgData()`

New in v2:

- `epgLite()` / `epgLiteData()`
- `m3uPlaylistUri()` / `m3uPlaylistUrl()`

## Model Migration

Legacy `XTremeCode*` models are still available. v2 canonical names are shorter:

- `XTremeCodeCategory` -> `Category`
- `XTremeCodeLiveStreamItem` -> `LiveStreamItem`
- `XTremeCodeVodItem` -> `VodItem`
- `XTremeCodeVodInfo` -> `VodInfo`
- `XTremeCodeSeriesItem` -> `SeriesItem`
- `XTremeCodeSeriesInfo` -> `SeriesInfo`
- `XTremeCodeChannelEpg` -> `ChannelEpg`
- `XTremeCodeChannelEpgTable` -> `ChannelEpgTable`
- `XTremeCodeGeneralInformation` -> `GeneralInformation`

## Recommended Migration Sequence

1. Switch construction to `XtreamClient`.
2. Replace legacy method calls with v2 equivalents.
3. Start with `*Data()` helpers to minimize immediate refactor scope.
4. Move to `ApiResult<T>` where warnings/metadata matter.
5. Remove dependencies on deprecated legacy classes.
