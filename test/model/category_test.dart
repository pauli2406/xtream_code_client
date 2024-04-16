import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeCategory', () {
    test('fromJson should parse json correctly', () {
      // Mock JSON with string values
      final mockJsonString = {
        'category_id': '1',
        'category_name': 'Test Category',
        'parent_id': '0'
      };

      var category = XTremeCodeCategory.fromJson(mockJsonString);
      expect(category.categoryId, 1);
      expect(category.categoryName, 'Test Category');
      expect(category.parentId, 0);

      // Mock JSON with integer values
      final mockJsonInt = {
        'category_id': 1,
        'category_name': 'Test Category',
        'parent_id': 0,
      };

      category = XTremeCodeCategory.fromJson(mockJsonInt);
      expect(category.categoryId, 1);
      expect(category.categoryName, 'Test Category');
      expect(category.parentId, 0);
    });
  });
}
