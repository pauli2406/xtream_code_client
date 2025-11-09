/// Parser for converting dynamic values to lists.
abstract class ListParser {
  const ListParser();

  /// Parses a dynamic value to a list of strings.
  List<String>? parseStringList(dynamic json);

  /// Parses a dynamic value to a list of integers.
  List<int>? parseIntList(dynamic json);

  /// Creates a parser for string lists.
  factory ListParser.stringList() => const SmartStringListParser();

  /// Creates a parser for integer lists.
  factory ListParser.intList() => const SmartIntListParser();
}

/// Smart parser for string lists.
class SmartStringListParser extends ListParser {
  const SmartStringListParser();

  @override
  List<String>? parseStringList(dynamic json) {
    if (json == null) return null;

    if (json is Iterable) {
      final result = <String>[];
      for (final dynamic item in json) {
        if (item == null) continue;
        result.add(item.toString());
      }
      return result;
    }

    return [json.toString()];
  }

  @override
  List<int>? parseIntList(dynamic json) {
    if (json == null) return null;

    if (json is Iterable) {
      final result = <int>[];
      for (final dynamic item in json) {
        if (item == null) continue;
        if (item is int) {
          result.add(item);
        } else if (item is num) {
          result.add(item.toInt());
        } else if (item is String) {
          final value = int.tryParse(item);
          if (value != null) result.add(value);
        }
      }
      return result;
    }

    if (json is int) return [json];
    if (json is num) return [json.toInt()];
    if (json is String) {
      final value = int.tryParse(json);
      return value != null ? [value] : null;
    }

    return null;
  }
}

/// Smart parser for integer lists.
class SmartIntListParser extends ListParser {
  const SmartIntListParser();

  @override
  List<String>? parseStringList(dynamic json) {
    if (json == null) return null;

    if (json is Iterable) {
      final result = <String>[];
      for (final dynamic item in json) {
        if (item == null) continue;
        result.add(item.toString());
      }
      return result;
    }

    return [json.toString()];
  }

  @override
  List<int>? parseIntList(dynamic json) {
    if (json == null) return null;

    if (json is Iterable) {
      final result = <int>[];
      for (final dynamic item in json) {
        if (item == null) continue;
        if (item is int) {
          result.add(item);
        } else if (item is num) {
          result.add(item.toInt());
        } else if (item is String) {
          final value = int.tryParse(item);
          if (value != null) result.add(value);
        }
      }
      return result;
    }

    if (json is int) return [json];
    if (json is num) return [json.toInt()];
    if (json is String) {
      final value = int.tryParse(json);
      return value != null ? [value] : null;
    }

    return null;
  }
}

