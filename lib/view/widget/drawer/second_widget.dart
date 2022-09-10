import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controller/drawer_controller.dart';
import '../../../controller/home_controller.dart';

class SecondWidget extends StatelessWidget {
  final TabController tabController;
  const SecondWidget({
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
                onPressed: () => tabController.animateTo(0),
                icon: const Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Text(
                  drawerController.selectedDrawerItem,
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
          itemCount: homeController.mainCategories.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final item = homeController.mainCategories[index];
            return ListTile(
              onTap: () {
                drawerController.setSelectedFirstCategory([
                  item.name,
                  item.id,
                ]);
                tabController.animateTo(2);
                homeController.findFirstCategories(item.id);
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
