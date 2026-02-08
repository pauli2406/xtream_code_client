import 'package:xtream_code_client/src/v2/core/parse_context.dart';

/// Scalar and collection parsers that tolerate mixed server payloads.
class ValueParser {
  static final RegExp _numericPattern = RegExp(r'^-?\d+(?:\.\d+)?$');
  static final RegExp _dateOnlyPattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  static final RegExp _timezonePattern =
      RegExp(r'(Z|[+-]\d{2}:?\d{2})$', caseSensitive: false);

  static int? asInt(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is int) {
      return raw;
    }

    if (raw is num) {
      final intValue = raw.toInt();
      if (raw != intValue) {
        context.addWarning(
          code: 'int_truncated',
          jsonPath: jsonPath,
          rawValue: raw,
          message: 'Value had decimal component and was truncated to int.',
        );
      }
      return intValue;
    }

    if (raw is String) {
      final value = raw.trim();
      if (value.isEmpty) {
        return null;
      }
      final directInt = int.tryParse(value);
      if (directInt != null) {
        return directInt;
      }
      final maybeNum = num.tryParse(value);
      if (maybeNum != null) {
        final intValue = maybeNum.toInt();
        if (maybeNum != intValue) {
          context.addWarning(
            code: 'int_truncated',
            jsonPath: jsonPath,
            rawValue: raw,
            message: 'String number had decimal component and was truncated.',
          );
        }
        return intValue;
      }
    }

    context.addWarning(
      code: 'invalid_int',
      jsonPath: jsonPath,
      rawValue: raw,
      message: 'Could not parse value as int.',
    );
    return null;
  }

  static double? asDouble(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is num) {
      return raw.toDouble();
    }

    if (raw is String) {
      final value = raw.trim();
      if (value.isEmpty) {
        return null;
      }
      final parsed = double.tryParse(value);
      if (parsed != null) {
        return parsed;
      }
    }

    context.addWarning(
      code: 'invalid_double',
      jsonPath: jsonPath,
      rawValue: raw,
      message: 'Could not parse value as double.',
    );
    return null;
  }

  static bool? asBool(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is bool) {
      return raw;
    }

    if (raw is num) {
      if (raw == 1) {
        return true;
      }
      if (raw == 0) {
        return false;
      }
    }

    if (raw is String) {
      final value = raw.trim().toLowerCase();
      if (value.isEmpty) {
        return null;
      }
      if (value == '1' || value == 'true') {
        return true;
      }
      if (value == '0' || value == 'false') {
        return false;
      }
    }

    context.addWarning(
      code: 'invalid_bool',
      jsonPath: jsonPath,
      rawValue: raw,
      message: 'Could not parse value as bool.',
    );
    return null;
  }

  static String? asString(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is String) {
      return raw;
    }

    if (raw is num || raw is bool) {
      return raw.toString();
    }

    context.addWarning(
      code: 'invalid_string',
      jsonPath: jsonPath,
      rawValue: raw,
      message: 'Could not parse value as string.',
    );
    return null;
  }

  static DateTime? asDateTimeUtc(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is DateTime) {
      return raw.toUtc();
    }

    if (raw is num) {
      return _fromNumericEpoch(raw, context, jsonPath);
    }

    if (raw is String) {
      final value = raw.trim();
      if (value.isEmpty) {
        return null;
      }

      if (_numericPattern.hasMatch(value)) {
        final numeric = num.tryParse(value);
        if (numeric != null) {
          return _fromNumericEpoch(numeric, context, jsonPath);
        }
      }

      final normalized = value.replaceFirst(' ', 'T');
      try {
        if (_timezonePattern.hasMatch(normalized)) {
          return DateTime.parse(normalized).toUtc();
        }

        if (_dateOnlyPattern.hasMatch(normalized)) {
          return DateTime.parse('${normalized}T00:00:00Z').toUtc();
        }

        return DateTime.parse('${normalized}Z').toUtc();
      } on FormatException {
        context.addWarning(
          code: 'invalid_datetime',
          jsonPath: jsonPath,
          rawValue: raw,
          message: 'Could not parse value as UTC DateTime.',
        );
        return null;
      }
    }

    context.addWarning(
      code: 'invalid_datetime',
      jsonPath: jsonPath,
      rawValue: raw,
      message: 'Could not parse value as UTC DateTime.',
    );
    return null;
  }

  static List<String>? asStringList(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is Iterable) {
      final result = <String>[];
      var index = 0;
      for (final value in raw) {
        if (value == null) {
          index++;
          continue;
        }
        final stringValue = asString(value, context, '$jsonPath[$index]');
        if (stringValue != null) {
          result.add(stringValue);
        }
        index++;
      }
      return result;
    }

    final single = asString(raw, context, jsonPath);
    return single == null ? null : <String>[single];
  }

  static List<int>? asIntList(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is Iterable) {
      final result = <int>[];
      var index = 0;
      for (final value in raw) {
        final parsed = asInt(value, context, '$jsonPath[$index]');
        if (parsed != null) {
          result.add(parsed);
        }
        index++;
      }
      return result;
    }

    final single = asInt(raw, context, jsonPath);
    return single == null ? null : <int>[single];
  }

  static Map<String, dynamic>? asMap(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is Map<String, dynamic>) {
      return raw;
    }

    if (raw is Map) {
      return raw.map<String, dynamic>(
        (key, value) => MapEntry(key.toString(), value),
      );
    }

    context.addWarning(
      code: 'invalid_map',
      jsonPath: jsonPath,
      rawValue: raw,
      message: 'Expected an object/map value.',
    );
    return null;
  }

  static List<Map<String, dynamic>> asMapList(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    if (raw == null) {
      return <Map<String, dynamic>>[];
    }

    if (raw is Iterable) {
      final result = <Map<String, dynamic>>[];
      var index = 0;
      for (final item in raw) {
        final parsed = asMap(item, context, '$jsonPath[$index]');
        if (parsed != null) {
          result.add(parsed);
        }
        index++;
      }
      return result;
    }

    if (raw is Map) {
      final map = asMap(raw, context, jsonPath);
      if (map == null) {
        return <Map<String, dynamic>>[];
      }

      final valuesAsMaps =
          map.values.whereType<Map<dynamic, dynamic>>().toList();
      if (valuesAsMaps.length == map.length && map.isNotEmpty) {
        context.addWarning(
          code: 'map_values_list_normalized',
          jsonPath: jsonPath,
          rawValue: raw,
          message: 'Object values were normalized into a list of objects.',
        );
        return valuesAsMaps
            .map(
              (value) => value.map<String, dynamic>(
                (key, nestedValue) => MapEntry(key.toString(), nestedValue),
              ),
            )
            .toList();
      }

      context.addWarning(
        code: 'single_object_list_normalized',
        jsonPath: jsonPath,
        rawValue: raw,
        message: 'Single object was normalized into a one-item list.',
      );
      return <Map<String, dynamic>>[map];
    }

    context.addWarning(
      code: 'invalid_list',
      jsonPath: jsonPath,
      rawValue: raw,
      message: 'Expected a list value.',
    );
    return <Map<String, dynamic>>[];
  }

  static DateTime? _fromNumericEpoch(
    num value,
    ParseContext context,
    String jsonPath,
  ) {
    if (value.isNaN || value.isInfinite) {
      context.addWarning(
        code: 'invalid_datetime',
        jsonPath: jsonPath,
        rawValue: value,
        message: 'Epoch value was not finite.',
      );
      return null;
    }

    final intValue = value.toInt();
    final abs = intValue.abs();
    final isMilliseconds = abs >= 100000000000;
    final milliseconds = isMilliseconds ? intValue : intValue * 1000;
    return DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
  }
}
