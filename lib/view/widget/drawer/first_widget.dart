import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/view/widget/drawer/admin_panel.dart';

import '../../../constant/mock.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/drawer_controller.dart';
import 'authenticated_profile.dart';
import 'image_profile.dart';
import 'unauthenticated_profile.dart';

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
    final AuthController authController = Get.find();
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 15),
        //Profile
        ImageProfile(authController: authController),
        const SizedBox(height: 15),
        //Authenticated User Or NOt
        Obx(() => (authController.currentUser.value!.status == 0)
            ? const UnAuthenticatedProfile()
            : const AuthenticatedProfile()),
        Obx(() {
          final isAuthenticate = authController.currentUser.value!.status! > 0;
          final isAdmin =
              isAuthenticate && authController.currentUser.value!.status! == 2;
          return isAdmin
              ? ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  children: [
                    const AdminPanel(),
                    NormalUser(
                        homeController: homeController,
                        drawerController: drawerController,
                        tabController: tabController)
                  ],
                )
              : NormalUser(
                  homeController: homeController,
                  drawerController: drawerController,
                  tabController: tabController);
        }),
      ]),
    );
  }
}

class NormalUser extends StatelessWidget {
  const NormalUser({
    Key? key,
    required this.homeController,
    required this.drawerController,
    required this.tabController,
  }) : super(key: key);

  final HomeController homeController;
  final AppDrawerController drawerController;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: drawerItems.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = drawerItems[index];
        return ListTile(
          onTap: () {
            if (index == 0) {
              //Original Widget
              Get.back();
              homeController.setSelectedLastParentId = "";
              return;
            }
            if (index == 3) {
              //Favourite Screen
              homeController.setSelectedLastParentId = "";
              Get.toNamed(favouriteScreen);
              return;
            }
            drawerController.setSelectedDrawerItem(item.name);
            tabController.animateTo(1);
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
    );
  }
}
