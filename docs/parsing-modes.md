# Parsing Modes

## Overview

Parsing behavior is controlled by `ParserOptions.mode`.

- `ParseMode.lenient` (default)
- `ParseMode.strict`

## Lenient Mode

Lenient mode is designed for inconsistent Xtream implementations.

Behavior:

- Attempts multiple accepted representations (for booleans, numbers, dates, etc.).
- Uses fallback values (`null` for invalid scalar fields, empty object/list for malformed top-level shapes where applicable).
- Emits `ParseWarning` entries instead of crashing.

`ParseWarning` includes:

- `code`: machine-friendly warning type
- `jsonPath`: source location in payload
- `rawValue`: original value that failed conversion
- `message`: human explanation

## Strict Mode

Strict mode enforces type correctness and fails fast on invalid payload data.

```dart
final client = XtreamClient(
  url: 'https://provider.example',
  username: 'u',
  password: 'p',
  parserOptions: const ParserOptions.strict(),
);
```

Use strict mode when malformed server data should immediately fail CI, integration tests, or backend processing.

## Accepted Scalar Formats

The parser accepts mixed formats common in Xtream payloads.

- Booleans: `"1"`, `"0"`, `"true"`, `"false"`, `1`, `0`, `true`, `false`
- Numbers: numeric values and numeric strings like `"123"`, `"4.5"`
- Date/time: epoch seconds, epoch milliseconds, numeric strings, ISO-8601, and `yyyy-MM-dd HH:mm:ss`

All v2 model date/time fields are normalized to UTC.

## Field Aliases

The parser resolves common alias variants, including:

- `release_date`, `releaseDate`, `releasedate`
- `end`, `stop`, `stop_timestamp`

If conflicting alias values are found, priority order is used and warnings are recorded.

## Related

- [Troubleshooting](troubleshooting.md)
- [Performance tuning](performance-tuning.md)
