import 'package:flutter/material.dart';

class DrawerItem {
  final String name;
  String? status;
  IconData? icon;
  bool isRow;
  DrawerItem({
    required this.name,
    this.status,
    this.icon,
    this.isRow = false,
  });
}