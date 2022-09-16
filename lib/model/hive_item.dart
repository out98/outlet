import 'dart:core';

import 'package:hive/hive.dart';

part 'hive_item.g.dart';

@HiveType(typeId: 8)
class HiveItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String features;
  @HiveField(3)
  String image;
  @HiveField(4)
  int count;
  @HiveField(5)
  int price;
  @HiveField(6)
  int dicountPrice;
  @HiveField(7)
  int requirePoints;
  HiveItem({
    required this.id,
    required this.name,
    required this.features,
    required this.image,
    required this.price,
    required this.dicountPrice,
    required this.requirePoints,
    required this.count,
  });
}
