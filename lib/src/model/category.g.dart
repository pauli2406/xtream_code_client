// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XTremeCodeCategory _$XTremeCodeCategoryFromJson(Map<String, dynamic> json) =>
    XTremeCodeCategory(
      categoryId: dynamicToIntConverter(json['category_id']),
      categoryName: json['category_name'] as String?,
      parentId: dynamicToIntConverter(json['parent_id']),
    );

Map<String, dynamic> _$XTremeCodeCategoryToJson(XTremeCodeCategory instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'parent_id': instance.parentId,
    };
