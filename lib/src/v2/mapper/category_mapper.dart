import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';
import 'package:xtream_code_client/src/v2/model/category.dart';

class CategoryMapper {
  static Category fromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return Category(
      categoryId: ValueParser.asInt(
          json['category_id'], context, '$jsonPath.category_id'),
      categoryName: ValueParser.asString(
          json['category_name'], context, '$jsonPath.category_name'),
      parentId:
          ValueParser.asInt(json['parent_id'], context, '$jsonPath.parent_id'),
    );
  }

  static List<Category> fromList(
    List<Map<String, dynamic>> items,
    ParseContext context,
    String jsonPath,
  ) {
    final result = <Category>[];
    for (var index = 0; index < items.length; index++) {
      result.add(fromMap(items[index], context, '$jsonPath[$index]'));
    }
    return result;
  }
}
