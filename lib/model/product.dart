import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    required String id,
    required String name,
    required List<String> image,
    required String description,
    @JsonKey(nullable: true) String? features,
    required int price,
    @JsonKey(nullable: true) String? status,
    @JsonKey(nullable: true) String? brandId,
    required String parentId,
    @JsonKey(nullable: true) double? rating,
    required DateTime dateTime,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
