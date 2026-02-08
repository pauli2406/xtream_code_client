import 'dart:convert';

import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';

/// Utilities for decoding endpoint payloads into predictable object/list forms.
class ResponseNormalizer {
  static dynamic decodeJsonBody(
    String body,
    ParseContext context,
    String jsonPath,
  ) {
    try {
      return json.decode(body);
    } on FormatException catch (error) {
      context.addWarning(
        code: 'invalid_json',
        jsonPath: jsonPath,
        rawValue: body,
        message: 'Failed to decode JSON body: ${error.message}',
      );
      return null;
    }
  }

  static Map<String, dynamic> expectObject(
    dynamic value,
    ParseContext context,
    String jsonPath,
  ) {
    final map = ValueParser.asMap(value, context, jsonPath);
    return map ?? <String, dynamic>{};
  }

  static List<Map<String, dynamic>> expectObjectList(
    dynamic value,
    ParseContext context,
    String jsonPath,
  ) {
    return ValueParser.asMapList(value, context, jsonPath);
  }

  static List<Map<String, dynamic>> readObjectListField(
    Map<String, dynamic> root,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    if (!root.containsKey(key) || root[key] == null) {
      return <Map<String, dynamic>>[];
    }
    return expectObjectList(root[key], context, '$jsonPath.$key');
  }

  static Map<String, dynamic> readObjectField(
    Map<String, dynamic> root,
    String key,
    ParseContext context,
    String jsonPath,
  ) {
    if (!root.containsKey(key) || root[key] == null) {
      context.addWarning(
        code: 'missing_object_field',
        jsonPath: '$jsonPath.$key',
        rawValue: null,
        message: 'Expected object field is missing.',
      );
      return <String, dynamic>{};
    }
    return expectObject(root[key], context, '$jsonPath.$key');
  }
}
