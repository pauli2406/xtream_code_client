import 'package:flutter_test/flutter_test.dart';
import 'package:xtream_code_client/xtream_code_client.dart';

void main() {
  group('XTremeCodeCategory', () {
    final mockJsonString = {
      'category_id': '1',
      'category_name': 'Test Category',
      'parent_id': '0',
    };

    test('fromJson should parse json with string values correctly', () {
      final category = XTremeCodeCategory.fromJson(mockJsonString);
      expect(category.categoryId, 1);
      expect(category.categoryName, 'Test Category');
      expect(category.parentId, 0);
    });

    test('fromJson should parse json with integer values correctly', () {
      final mockJsonInt = {
        'category_id': 1,
        'category_name': 'Test Category',
        'parent_id': 0,
      };

      final category = XTremeCodeCategory.fromJson(mockJsonInt);
      expect(category.categoryId, 1);
      expect(category.categoryName, 'Test Category');
      expect(category.parentId, 0);
    });
  });
}
