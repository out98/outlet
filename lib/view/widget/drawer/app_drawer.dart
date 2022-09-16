import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/view/widget/drawer/drawer.dart';

import '../../../controller/drawer_controller.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    Get.put(AppDrawerController());
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    debugPrint("******Hofuly disposed***");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint("Dispose");
        return true;
      },
      child: Drawer(
        child: SafeArea(
          child: SizedBox(
            width: widget.size.width / 2,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                FirstWidget(
                  tabController: tabController,
                ),
                SecondWidget(tabController: tabController),
                ThirdWidget(tabController: tabController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
