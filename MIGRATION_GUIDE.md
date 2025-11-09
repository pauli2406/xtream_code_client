# Migration Guide: 1.x → 2.0.0

This guide will help you migrate from version 1.x to version 2.0.0 of the `xtream_code_client` package.

## Overview

Version 2.0.0 introduces a **Smart Parser System** that automatically handles inconsistent API responses from different Xtream Code server implementations. While the API remains backward compatible, this is a major version bump to highlight the significant improvements in parsing reliability.

## What Changed?

### ✨ New Features

1. **Smart Parser System** - Automatically detects and handles multiple date/number/boolean formats
2. **Parser Configuration** - Optional `ParserConfig` parameter for custom field parsing
3. **Improved Compatibility** - Handles inconsistencies like the `end` field using different formats across endpoints
4. **Better Error Handling** - No more crashes on unexpected formats

### 🔧 Internal Improvements

- All converter functions now use smart parsers internally
- Fixed missing converters for `stop`, `releaseDate`, and `releasedate` fields
- Improved parsing logic for dates, numbers, booleans, and lists

### 📦 New Exports

- `ParserConfig` - Parser configuration class
- `DateParser` and implementations (`SmartDateParser`, `EpochSecondsParser`, `Iso8601Parser`, `CustomDateParser`)
- `NumberParser` and implementations (`SmartIntParser`, `SmartDoubleParser`)
- `BooleanParser` and implementations (`SmartBooleanParser`)
- `ListParser` and implementations (`SmartStringListParser`, `SmartIntListParser`)

## Migration Steps

### Step 1: Update Your Dependencies

Update your `pubspec.yaml`:

```yaml
dependencies:
  xtream_code_client: ^2.0.0
```

Then run:

```bash
flutter pub get
```

### Step 2: Regenerate Generated Files

If you have any custom models or extensions, regenerate your `.g.dart` files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Review Your Code (Optional)

**Good news:** Your existing code should work without any changes! The smart parser system is backward compatible and will automatically handle format inconsistencies.

However, you may want to:

1. **Remove manual format handling** - If you had workarounds for parsing issues, you can likely remove them
2. **Add custom parsers** - If you know your server uses specific formats, you can optimize parsing with `ParserConfig`

## Breaking Changes

### ⚠️ None!

This release is **100% backward compatible**. All existing code continues to work without changes. The version bump to 2.0.0 reflects the significant internal improvements and new capabilities, not breaking API changes.

## New Capabilities

### Automatic Format Detection (Default Behavior)

By default, the library now automatically handles:

- **Date/Time Formats:**
  - ISO 8601: `"2024-04-09T01:35:00Z"`
  - Weird formats: `"2024-04-09 01:35:00"`
  - Epoch seconds: `1712619300` or `"1712619300"`
  - Epoch milliseconds: `1712619300000`

- **Number Formats:**
  - Integers as strings: `"123"` → `123`
  - Doubles as strings: `"4.5"` → `4.5`

- **Boolean Formats:**
  - String: `"1"`, `"true"` → `true`
  - Number: `1` → `true`

### Custom Parser Configuration (Optional)

If you want to override specific fields or optimize for known formats:

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
  parserConfig: config, // Optional: use custom config
);
```

### Custom Parser for Non-Standard Formats

For truly non-standard formats:

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

## Examples

### Before (1.x) - Still Works!

```dart
await XtreamCode.initialize(
  url: 'https://your-server-url',
  port: '8080',
  username: 'your-username',
  password: 'your-password',
);

final client = XtreamCode.instance.client;
final info = await client.serverInformation();
```

### After (2.0.0) - Same Code, Better Parsing!

```dart
// Works exactly the same, but with improved parsing
await XtreamCode.initialize(
  url: 'https://your-server-url',
  port: '8080',
  username: 'your-username',
  password: 'your-password',
);

final client = XtreamCode.instance.client;
final info = await client.serverInformation();
```

### After (2.0.0) - With Custom Configuration

```dart
// Optional: Add custom parser configuration
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

final client = XtreamCode.instance.client;
final info = await client.serverInformation();
```

## Troubleshooting

### Issue: Dates Still Not Parsing Correctly

**Solution:** Use field-specific overrides:

```dart
final config = ParserConfig.override(
  dateFieldParsers: {
    'problematic_field': DateParser.epochSeconds(),
  },
);
```

### Issue: Numbers Coming as Strings

**Solution:** This is now handled automatically! But if you need to force a specific parser:

```dart
final config = ParserConfig.override(
  numberFieldParsers: {
    'specific_field': NumberParser.intFlexible(),
  },
);
```

### Issue: Need to Debug Parsing

**Solution:** Enable debug logging:

```dart
await XtreamCode.initialize(
  url: '...',
  port: '...',
  username: '...',
  password: '...',
  debug: true, // Enable debug logging
);
```

## Performance Notes

The smart parser system tries multiple formats, but the performance impact is negligible compared to network I/O. Most formats are detected on the first attempt. If performance is critical, you can use field-specific overrides to skip format detection for known fields.

## Need Help?

If you encounter any issues during migration:

1. Check the [README.md](README.md) for detailed usage examples
2. Review the [CHANGELOG.md](CHANGELOG.md) for all changes
3. Open an issue on [GitHub](https://github.com/pauli2406/xtream_code_client/issues)

## Summary

- ✅ **No code changes required** - Your existing code works as-is
- ✅ **Better parsing** - Automatic format detection handles inconsistencies
- ✅ **Optional customization** - Add `ParserConfig` when needed
- ✅ **Backward compatible** - All existing APIs remain unchanged

Enjoy the improved reliability! 🎉

