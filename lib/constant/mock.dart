import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/drawer_item.dart';

const mockProfile =
    "https://png.pngtree.com/png-vector/20191103/ourmid/pngtree-handsome-young-guy-avatar-cartoon-style-png-image_1947775.jpg";

final List<DrawerItem> drawerItems = [
  DrawerItem(name: "top page", status: "TOP"),
  DrawerItem(name: "Feature List/Product Information", status: "PRODUCT"),
  //DrawerItem(name: "brand", status: "BRAND"),
  DrawerItem(
      name: "view favourites", icon: FontAwesomeIcons.solidHeart, isRow: true),
  DrawerItem(
      // ignore: deprecated_member_use
      name: "Purchase History",
      icon: FontAwesomeIcons.history)
];
