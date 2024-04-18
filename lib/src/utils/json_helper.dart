/// Converts a string of seconds since Epoch (1970-01-01T00:00:00Z) to a
/// [DateTime].
/// Returns null if [seconds] is null or empty.
DateTime? dateTimeFromEpochSeconds(dynamic seconds) {
  if (seconds == null) {
    return null;
  }

  int? epochSeconds;

  if (seconds is String) {
    if (seconds.isEmpty) {
      return null;
    }
    epochSeconds = int.tryParse(seconds);
  } else if (seconds is num) {
    epochSeconds = seconds.toInt();
  }

  return epochSeconds == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(epochSeconds * 1000);
}

/// Converts a string in ISO 8601 format to a [DateTime].
/// Returns null if [dateTime] is null or empty.
DateTime? dateTimeFromString(String? dateTime) =>
    (dateTime == null || dateTime.isEmpty) ? null : DateTime.parse(dateTime);

/// Converts a string, integer, or boolean to a boolean.
/// Returns true if [value] is '1', 1, or true, otherwise returns false.
bool dynamicToBool(dynamic value) {
  if (value is String) {
    return value == '1';
  } else if (value is num) {
    return value == 1;
  } else if (value is bool) {
    return value;
  }

  return false;
}

/// Converts a dynamic value to an integer.
/// Returns the integer value if conversion is successful, otherwise returns
/// null.
int? dynamicToIntConverter(dynamic json) {
  if (json == null) {
    return null;
  }
  if (json is num) {
    return json.toInt();
  }
  if (json is String) {
    return int.tryParse(json);
  }
  return null;
}

/// Converts a dynamic value to a double.
/// Returns the double value if conversion is successful, otherwise
/// returns null.
double? dynamicToDoubleConverter(dynamic json) {
  if (json == null) {
    return null;
  }
  if (json is num) {
    return json.toDouble();
  }
  if (json is String) {
    return double.tryParse(json);
  }
  return null;
}
