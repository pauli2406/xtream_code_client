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
      categoryId: ValueParser.readInt(
        json,
        'category_id',
        context,
        jsonPath,
      ),
      categoryName: ValueParser.readString(
        json,
        'category_name',
        context,
        jsonPath,
      ),
      parentId: ValueParser.readInt(
        json,
        'parent_id',
        context,
        jsonPath,
      ),
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
