import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';

import '../../../constant/mock.dart';
import '../../../controller/drawer_controller.dart';

class FirstWidget extends StatelessWidget {
  final TabController tabController;
  const FirstWidget({
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
        child: const Center(
          child: Text(
            "MENU",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
              letterSpacing: 5,
            ),
          ),
        ),
      ),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: drawerItems.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final item = drawerItems[index];
            return ListTile(
              onTap: () {
                if (index == 0) {
                  Get.back();
                  homeController.setSelectedLastParentId = "";
                } else {
                  drawerController.setSelectedDrawerItem(item.name);
                  tabController.animateTo(1);
                }
              },
              title: item.isRow
                  ? Row(
                      children: [
                        Icon(item.icon, color: Colors.pink),
                        const SizedBox(width: 10),
                        Text(
                          item.name,
                        )
                      ],
                    )
                  : Text(item.name),
              subtitle: Text(
                item.status ?? "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
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
