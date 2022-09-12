import 'package:hive/hive.dart';

part 'hive_product.g.dart';

@HiveType(typeId: 1)
class HiveProduct {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  String description;
  @HiveField(4)
  String features;
  @HiveField(5)
  int price;
  HiveProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.features,
    required this.price,
  });
}
