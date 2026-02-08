import 'package:xtream_code_client/src/v2/core/parse_context.dart';

/// Resolves canonical fields from multiple known source aliases.
class FieldAliases {
  static dynamic resolve(
    Map<String, dynamic> json,
    List<String> aliases,
    ParseContext context,
    String jsonPath,
  ) {
    dynamic chosenValue;
    String? chosenAlias;
    final present = <String, dynamic>{};

    for (final alias in aliases) {
      if (!json.containsKey(alias)) {
        continue;
      }
      final value = json[alias];
      if (value == null) {
        continue;
      }
      present[alias] = value;
      if (chosenAlias == null) {
        chosenAlias = alias;
        chosenValue = value;
      }
    }

    if (chosenAlias == null) {
      return null;
    }

    for (final entry in present.entries) {
      if (entry.key == chosenAlias) {
        continue;
      }
      if (!_looselyEqual(chosenValue, entry.value)) {
        context.addWarning(
          code: 'alias_conflict',
          jsonPath: '$jsonPath.${entry.key}',
          rawValue: entry.value,
          message:
              'Conflicting alias values detected. "$chosenAlias" was chosen.',
        );
      }
    }

    return chosenValue;
  }

  static bool _looselyEqual(dynamic left, dynamic right) {
    if (left == right) {
      return true;
    }

    if (left is num && right is num) {
      return left.toDouble() == right.toDouble();
    }

    return left.toString() == right.toString();
  }
}
