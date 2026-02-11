# Performance Tuning

## Background Parsing

`ParserOptions` controls isolate offloading:

```dart
const parserOptions = ParserOptions(
  backgroundParsingMode: BackgroundParsingMode.auto,
  jsonIsolateMinBytes: 131072,
  xmlIsolateMinBytes: 98304,
);
```

### `BackgroundParsingMode`

- `off`: parse on caller isolate only.
- `auto` (default): offload only when payload size reaches configured thresholds.
- `always`: always offload parse jobs.

If isolate execution is unavailable in a runtime, parsing falls back to synchronous execution.

## Threshold Fields

### `jsonIsolateMinBytes`

Minimum JSON payload size (in bytes) required to offload in `auto` mode.

Default: `131072` bytes (`128 KiB`).

### `xmlIsolateMinBytes`

Minimum XML payload size (in bytes) required to offload in `auto` mode.

Default: `98304` bytes (`96 KiB`).

XML is generally more CPU-intensive than JSON, so the XML threshold is lower by default.

## Presets

### UI-first

Use when parsing happens in user-facing flows and frame smoothness matters.

- `backgroundParsingMode: BackgroundParsingMode.auto`
- `jsonIsolateMinBytes: 131072`
- `xmlIsolateMinBytes: 98304`

### Balanced

Use for mixed UI and background workloads.

- `backgroundParsingMode: BackgroundParsingMode.auto`
- `jsonIsolateMinBytes: 262144`
- `xmlIsolateMinBytes: 131072`

### Throughput/background

Use for batch processing where isolate handoff overhead should be minimized.

Option A:

- `backgroundParsingMode: BackgroundParsingMode.off`

Option B:

- `backgroundParsingMode: BackgroundParsingMode.auto`
- `jsonIsolateMinBytes: 524288` (or higher)
- `xmlIsolateMinBytes: 393216` (or higher)

## Choosing Values

1. Lower thresholds when you observe UI jank during parse-heavy calls.
2. Raise thresholds when small/medium payloads are slower due to isolate overhead.
3. Keep XML threshold lower than JSON unless your payloads are atypically small or sparse.
4. Measure with your real payload mix before finalizing values.

## Benchmark Workflow

Run local benchmarks:

```bash
dart run benchmark/perf_parse_benchmark.dart
dart run benchmark/perf_epg_benchmark.dart
```

Use the output to compare before/after threshold changes and validate your preset choice.
