import 'package:freezed_annotation/freezed_annotation.dart';

part 'first_sub_category.freezed.dart';
part 'first_sub_category.g.dart';

@freezed
class FirstSubCategory with _$FirstSubCategory{
  factory FirstSubCategory({
    required String id,
    required String name,
    required String parentId,
    required DateTime dateTime,
  }) = _FirstSubCategory;

  factory FirstSubCategory.fromJson(Map<String,dynamic> json)
  => _$FirstSubCategoryFromJson(json);
}