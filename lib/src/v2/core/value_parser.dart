import 'package:xtream_code_client/src/v2/core/parse_context.dart';

/// Scalar and collection parsers that tolerate mixed server payloads.
class ValueParser {
  static int? readInt(
    Map<String, dynamic> json,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    return _asInt(json[key], context, () => _fieldPath(jsonPath, key));
  }

  static double? readDouble(
    Map<String, dynamic> json,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    return _asDouble(json[key], context, () => _fieldPath(jsonPath, key));
  }

  static bool? readBool(
    Map<String, dynamic> json,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    return _asBool(json[key], context, () => _fieldPath(jsonPath, key));
  }

  static String? readString(
    Map<String, dynamic> json,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    return _asString(json[key], context, () => _fieldPath(jsonPath, key));
  }

  static DateTime? readDateTimeUtc(
    Map<String, dynamic> json,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    return _asDateTimeUtc(
      json[key],
      context,
      () => _fieldPath(jsonPath, key),
    );
  }

  static List<String>? readStringList(
    Map<String, dynamic> json,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    return _asStringList(
      json[key],
      context,
      () => _fieldPath(jsonPath, key),
    );
  }

  static List<int>? readIntList(
    Map<String, dynamic> json,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    return _asIntList(
      json[key],
      context,
      () => _fieldPath(jsonPath, key),
    );
  }

  static int? asInt(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    return _asInt(raw, context, () => jsonPath);
  }

  static double? asDouble(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    return _asDouble(raw, context, () => jsonPath);
  }

  static bool? asBool(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    return _asBool(raw, context, () => jsonPath);
  }

  static String? asString(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    return _asString(raw, context, () => jsonPath);
  }

  static DateTime? asDateTimeUtc(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    return _asDateTimeUtc(raw, context, () => jsonPath);
  }

  static List<String>? asStringList(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    return _asStringList(raw, context, () => jsonPath);
  }

  static List<int>? asIntList(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    return _asIntList(raw, context, () => jsonPath);
  }

  static Map<String, dynamic>? asMap(
    dynamic raw,
    ParseContext context,
    String jsonPath,
  ) {
    return _asMap(raw, context, () => jsonPath);
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
        final parsed = _asMap(
          item,
          context,
          () => '${jsonPath}[$index]',
        );
        if (parsed != null) {
          result.add(parsed);
        }
        index++;
      }
      return result;
    }

    if (raw is Map) {
      final map = _asMap(raw, context, () => jsonPath);
      if (map == null) {
        return <Map<String, dynamic>>[];
      }

      var allMapValues = map.isNotEmpty;
      for (final value in map.values) {
        if (value is! Map) {
          allMapValues = false;
          break;
        }
      }

      if (allMapValues) {
        context.addWarning(
          code: 'map_values_list_normalized',
          jsonPath: jsonPath,
          rawValue: raw,
          message: 'Object values were normalized into a list of objects.',
        );
        final result = <Map<String, dynamic>>[];
        for (final value in map.values) {
          result.add((value as Map).map<String, dynamic>(
            (key, nestedValue) => MapEntry(key.toString(), nestedValue),
          ));
        }
        return result;
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

  static int? _asInt(
    dynamic raw,
    ParseContext context,
    _PathBuilder pathBuilder,
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
          jsonPath: pathBuilder(),
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
            jsonPath: pathBuilder(),
            rawValue: raw,
            message: 'String number had decimal component and was truncated.',
          );
        }
        return intValue;
      }
    }

    context.addWarning(
      code: 'invalid_int',
      jsonPath: pathBuilder(),
      rawValue: raw,
      message: 'Could not parse value as int.',
    );
    return null;
  }

  static double? _asDouble(
    dynamic raw,
    ParseContext context,
    _PathBuilder pathBuilder,
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
      jsonPath: pathBuilder(),
      rawValue: raw,
      message: 'Could not parse value as double.',
    );
    return null;
  }

  static bool? _asBool(
    dynamic raw,
    ParseContext context,
    _PathBuilder pathBuilder,
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
      jsonPath: pathBuilder(),
      rawValue: raw,
      message: 'Could not parse value as bool.',
    );
    return null;
  }

  static String? _asString(
    dynamic raw,
    ParseContext context,
    _PathBuilder pathBuilder,
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
      jsonPath: pathBuilder(),
      rawValue: raw,
      message: 'Could not parse value as string.',
    );
    return null;
  }

  static DateTime? _asDateTimeUtc(
    dynamic raw,
    ParseContext context,
    _PathBuilder pathBuilder,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is DateTime) {
      return raw.toUtc();
    }

    if (raw is num) {
      return _fromNumericEpoch(raw, context, pathBuilder);
    }

    if (raw is String) {
      final value = raw.trim();
      if (value.isEmpty) {
        return null;
      }

      final numericEpoch = _tryNumericEpoch(value);
      if (numericEpoch != null) {
        return _fromNumericEpoch(numericEpoch, context, pathBuilder);
      }

      final dateOnly = _tryDateOnlyUtc(value);
      if (dateOnly != null) {
        return dateOnly;
      }

      final classicDateTime = _tryDateTimeWithoutTimezoneUtc(value);
      if (classicDateTime != null) {
        return classicDateTime;
      }

      final normalized =
          value.contains(' ') ? value.replaceFirst(' ', 'T') : value;
      try {
        if (_hasTimezone(normalized)) {
          return DateTime.parse(normalized).toUtc();
        }

        return DateTime.parse('${normalized}Z').toUtc();
      } on FormatException {
        context.addWarning(
          code: 'invalid_datetime',
          jsonPath: pathBuilder(),
          rawValue: raw,
          message: 'Could not parse value as UTC DateTime.',
        );
        return null;
      }
    }

    context.addWarning(
      code: 'invalid_datetime',
      jsonPath: pathBuilder(),
      rawValue: raw,
      message: 'Could not parse value as UTC DateTime.',
    );
    return null;
  }

  static List<String>? _asStringList(
    dynamic raw,
    ParseContext context,
    _PathBuilder pathBuilder,
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
        final stringValue = _asString(
          value,
          context,
          () => '${pathBuilder()}[$index]',
        );
        if (stringValue != null) {
          result.add(stringValue);
        }
        index++;
      }
      return result;
    }

    final single = _asString(raw, context, pathBuilder);
    return single == null ? null : <String>[single];
  }

  static List<int>? _asIntList(
    dynamic raw,
    ParseContext context,
    _PathBuilder pathBuilder,
  ) {
    if (raw == null) {
      return null;
    }

    if (raw is Iterable) {
      final result = <int>[];
      var index = 0;
      for (final value in raw) {
        final parsed = _asInt(
          value,
          context,
          () => '${pathBuilder()}[$index]',
        );
        if (parsed != null) {
          result.add(parsed);
        }
        index++;
      }
      return result;
    }

    final single = _asInt(raw, context, pathBuilder);
    return single == null ? null : <int>[single];
  }

  static Map<String, dynamic>? _asMap(
    dynamic raw,
    ParseContext context,
    _PathBuilder pathBuilder,
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
      jsonPath: pathBuilder(),
      rawValue: raw,
      message: 'Expected an object/map value.',
    );
    return null;
  }

  static DateTime? _fromNumericEpoch(
    num value,
    ParseContext context,
    _PathBuilder pathBuilder,
  ) {
    if (value.isNaN || value.isInfinite) {
      context.addWarning(
        code: 'invalid_datetime',
        jsonPath: pathBuilder(),
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

  static String _fieldPath(String jsonPath, String key) => '$jsonPath.$key';

  static num? _tryNumericEpoch(String value) {
    if (value.isEmpty) {
      return null;
    }

    final isNegative = value.startsWith('-');
    final digitStart = isNegative ? 1 : 0;
    if (digitStart == value.length) {
      return null;
    }

    var onlyDigits = true;
    for (var i = digitStart; i < value.length; i++) {
      final code = value.codeUnitAt(i);
      if (code < 48 || code > 57) {
        onlyDigits = false;
        break;
      }
    }

    if (onlyDigits &&
        (value.length - digitStart == 10 || value.length - digitStart == 13)) {
      return int.tryParse(value);
    }
    return null;
  }

  static DateTime? _tryDateOnlyUtc(String value) {
    if (value.length != 10 ||
        value.codeUnitAt(4) != 45 ||
        value.codeUnitAt(7) != 45) {
      return null;
    }

    final year = int.tryParse(value.substring(0, 4));
    final month = int.tryParse(value.substring(5, 7));
    final day = int.tryParse(value.substring(8, 10));
    if (year == null || month == null || day == null) {
      return null;
    }
    return DateTime.utc(year, month, day);
  }

  static DateTime? _tryDateTimeWithoutTimezoneUtc(String value) {
    if (value.length != 19) {
      return null;
    }
    if (value.codeUnitAt(4) != 45 ||
        value.codeUnitAt(7) != 45 ||
        (value.codeUnitAt(10) != 32 && value.codeUnitAt(10) != 84) ||
        value.codeUnitAt(13) != 58 ||
        value.codeUnitAt(16) != 58) {
      return null;
    }

    final year = int.tryParse(value.substring(0, 4));
    final month = int.tryParse(value.substring(5, 7));
    final day = int.tryParse(value.substring(8, 10));
    final hour = int.tryParse(value.substring(11, 13));
    final minute = int.tryParse(value.substring(14, 16));
    final second = int.tryParse(value.substring(17, 19));
    if (year == null ||
        month == null ||
        day == null ||
        hour == null ||
        minute == null ||
        second == null) {
      return null;
    }
    return DateTime.utc(year, month, day, hour, minute, second);
  }

  static bool _hasTimezone(String value) {
    if (value.isEmpty) {
      return false;
    }

    final last = value.codeUnitAt(value.length - 1);
    if (last == 90 || last == 122) {
      return true;
    }

    if (value.length >= 6) {
      final sign = value.codeUnitAt(value.length - 6);
      if ((sign == 43 || sign == 45) &&
          value.codeUnitAt(value.length - 3) == 58) {
        return true;
      }
    }

    if (value.length >= 5) {
      final sign = value.codeUnitAt(value.length - 5);
      if (sign == 43 || sign == 45) {
        return true;
      }
    }

    return false;
  }
}

typedef _PathBuilder = String Function();
