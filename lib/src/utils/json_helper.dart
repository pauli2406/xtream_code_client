import 'package:xtream_code_client/src/parser/boolean_parser.dart';
import 'package:xtream_code_client/src/parser/date_parser.dart';
import 'package:xtream_code_client/src/parser/list_parser.dart';
import 'package:xtream_code_client/src/parser/number_parser.dart';

/// Converts a string of seconds since Epoch (1970-01-01T00:00:00Z) to a
/// [DateTime].
/// Returns null if [seconds] is null or empty.
///
/// Uses smart parsing internally to handle various formats.
DateTime? dateTimeFromEpochSeconds(dynamic seconds) {
  return const SmartDateParser().parse(seconds);
}

/// Converts a string in ISO 8601 format to a [DateTime].
/// Returns null if [dateTime] is null or empty.
///
/// Uses smart parsing internally to handle various formats including
/// ISO 8601, epoch seconds, and weird date formats.
DateTime? dateTimeFromString(dynamic dateTime) {
  return const SmartDateParser().parse(dateTime);
}

/// Converts a string, integer, or boolean to a boolean.
/// Returns true if [value] is '1', 1, or true, otherwise returns false.
///
/// Uses smart parsing internally to handle various boolean representations.
bool dynamicToBool(dynamic value) {
  return const SmartBooleanParser().parse(value);
}

/// Converts a dynamic value to an integer.
/// Returns the integer value if conversion is successful, otherwise returns
/// null.
///
/// Uses smart parsing internally to handle string/int/double conversions.
int? dynamicToIntConverter(dynamic json) {
  return const SmartIntParser().parseInt(json);
}

/// Converts a dynamic value to a double.
/// Returns the double value if conversion is successful, otherwise
/// returns null.
///
/// Uses smart parsing internally to handle string/int/double conversions.
double? dynamicToDoubleConverter(dynamic json) {
  return const SmartDoubleParser().parseDouble(json);
}

/// Converts a dynamic json value to a list of strings.
///
/// If [json] is `null`, `null` is returned. Any `null` items within the list
/// are skipped. Non-string values are converted using `toString()`.
///
/// Uses smart parsing internally.
List<String>? stringListFromJson(dynamic json) {
  return const SmartStringListParser().parseStringList(json);
}

/// Converts a dynamic json value to a list of integers.
///
/// If [json] is `null`, `null` is returned. Any item that cannot be converted
/// to an integer is skipped.
///
/// Uses smart parsing internally.
List<int>? intListFromJson(dynamic json) {
  return const SmartIntListParser().parseIntList(json);
}
