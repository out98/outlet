import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/model/filter_enum.dart';

import '../../../controller/drawer_controller.dart';
import '../../../controller/home_controller.dart';

class ThirdWidget extends StatelessWidget {
  final TabController tabController;
  const ThirdWidget({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppDrawerController drawerController = Get.find();
    final HomeController homeController = Get.find();
    return Column(children: [
      //Menu
      Container(
          color: Colors.pink,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => tabController.animateTo(1),
                icon: const Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Text(
                  drawerController.selectedFirstCategory,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          )),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: homeController.selectedFirstCategories.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final item = homeController.selectedFirstCategories[index];
            return ListTile(
              onTap: () {
                homeController.findSelectedProducts(item.id);
                homeController.setFilterMainId = item.id;
                homeController.setFilterEnum = FilterEnum.oldestFirst;
                Get.back();
              },
              title: Text(item.name),
              trailing: const Icon(
                FontAwesomeIcons.chevronRight,
                color: Colors.pink,
              ),
            );
          },
        ),
      ),
    ]);
  }
}
