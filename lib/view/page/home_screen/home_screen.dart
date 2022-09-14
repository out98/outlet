import 'package:flutter/material.dart' hide Slider;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/constant/constant.dart';
import 'package:outlet/constant/mock.dart';
import 'package:outlet/view/page/result_products/view/result_product_view.dart';
import 'package:outlet/view/widget/home/advertisements_slider.dart';
import '../../../controller/home_controller.dart';
import '../../widget/drawer/app_drawer.dart';
import '../../widget/home/cliptoheretoshop.dart';
import '../../widget/home/brand_grid.dart';
import '../../widget/home/featurelistproductinformation.dart';
import '../../widget/home/hot_topics_slider.dart';
import '../../widget/home/item_recommended.dart';
import '../../widget/home/main_category_grid.dart';
import '../../widget/home/new_products.dart';
import '../../widget/home/row_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final HomeController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        title: Image.network(logo, height: 80),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      drawer: AppDrawer(size: size),
      body: Obx(() {
        return controller.filterMainId.isEmpty
            ? MainHome(size: size)
            : const ResultProductView();
      }),
    );
  }
}

class MainHome extends StatelessWidget {
  const MainHome({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const AdvertisementsSlider(),
        const MainCategoryGrid(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Topvalu incorporates customer feedback into its products",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const Divider(
          color: Colors.black54,
          height: 1,
        ),
        const SizedBox(height: 10),
        const RowText(left: "BRANDBrand", right: "/ information"),
        const SizedBox(height: 10),
        const BrandGrid(),
        const SizedBox(height: 10),
        const RowText(left: "HOT TOPICSrecommended", right: "/ information"),
        const SizedBox(height: 10),
        const HotTopicsSlider(),
        ClipHereToShop(size: size),
        const SizedBox(height: 15),
        const NewProducts(),
        const SizedBox(height: 20),
        const RowText(left: "RECOMMEND", right: ""),
        const RowText(left: "ITEMRecommended", right: "/ for you"),
        const SizedBox(height: 10),
        ItemRecommended(
          products: foodItems,
          title: "food",
        ),
        const SizedBox(height: 35),
        ItemRecommended(
          products: fashionItems,
          title: "fashion",
        ),
        const SizedBox(height: 35),
        ItemRecommended(
          products: dailyGoodsItems,
          title: "daily goods",
        ),
        const SizedBox(height: 35),
        ItemRecommended(
          products: homeCorrdyItems,
          title: "HOME CORRDY",
        ),
        const SizedBox(height: 35),
        //Feature List Product Information
        const FeatureListProductInformation()
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Left
        Column(
          children: [
            //Top
            //Bottom
          ],
        ),
        //Right
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.chevronRight,
            color: Colors.pink,
          ),
        ),
      ],
    );
  }
}
