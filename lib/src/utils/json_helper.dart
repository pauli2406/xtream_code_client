/// Converts a string of seconds since Epoch (1970-01-01T00:00:00Z) to a
/// [DateTime].
/// Returns null if [seconds] is null or empty.
DateTime? dateTimeFromEpochSeconds(String? seconds) =>
    (seconds == null || seconds.isEmpty)
        ? null
        : DateTime.fromMillisecondsSinceEpoch(int.parse(seconds) * 1000);

/// Converts an integer of seconds since Epoch (1970-01-01T00:00:00Z) to a
/// [DateTime].
/// Returns null if [seconds] is null.
DateTime? dateTimeFromEpochSecondsInt(int? seconds) => (seconds == null)
    ? null
    : DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

/// Converts a string in ISO 8601 format to a [DateTime].
/// Returns null if [dateTime] is null or empty.
DateTime? dateTimeFromString(String? dateTime) =>
    (dateTime == null || dateTime.isEmpty) ? null : DateTime.parse(dateTime);

/// Converts an integer to a boolean.
/// Returns true if [value] is 1, otherwise returns false.
bool intToBool(int value) => value == 1;


String? sometimesIntToString(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value.toString();
    }
    return value as String;
  }

double? doubleFromJson(dynamic json) {
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

int? intFromJson(dynamic json) {
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
