import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';
part 'brand.g.dart';

@freezed
class Brand with _$Brand {
  factory Brand({
    required String id,
    required String image,
    required String name,
    required String subName,
    required String status,
    String? description,
  }) = _Brand;
  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}
