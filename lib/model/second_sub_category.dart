import 'package:freezed_annotation/freezed_annotation.dart';

part 'second_sub_category.freezed.dart';
part 'second_sub_category.g.dart';

@freezed
class SecondSubCategory with _$SecondSubCategory{
  factory SecondSubCategory({
    required String id,
    required String name,
    required String parentId,
    required DateTime dateTime,
  }) = _SecondSubCategory;

  factory SecondSubCategory.fromJson(Map<String,dynamic> json)
  => _$SecondSubCategoryFromJson(json);
}