import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Slider;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/constant/constant.dart';
import 'package:outlet/constant/mock.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/view/page/result_products/view/result_product_view.dart';
import 'package:outlet/view/widget/home/advertisements_slider.dart';
import '../../../controller/home_controller.dart';
import '../../widget/drawer/app_drawer.dart';
import '../../widget/home/cart_icon.dart';
import '../../widget/home/cliptoheretoshop.dart';
import '../../widget/home/brand_grid.dart';
import '../../widget/home/featurelistproductinformation.dart';
import '../../widget/home/hot_topics_slider.dart';
import '../../widget/home/item_recommended.dart';
import '../../widget/home/main_category_grid.dart';
import '../../widget/home/new_products.dart';
import '../../widget/home/row_text.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? fltNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notitficationPermission();
    initMessaging();
  }

  void notitficationPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.toNamed(orderScreen);
  }

  void initMessaging() async {
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInit = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification!
        .initialize(initSetting, onSelectNotification: selectNotification);

    if (messaging != null) {
      print('vvvvvvv');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  void showNotification(RemoteMessage message) async {
    var androidDetails = AndroidNotificationDetails(
      '1',
      message.notification!.title ?? '',
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF0f90f3),
    );
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await fltNotification!.show(0, message.notification!.title ?? '',
        message.notification!.body ?? '', generalNotificationDetails,
        payload: 'Notification');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final HomeController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        title: Image.asset("assets/logo.png", height: 80),
        centerTitle: true,
        actions: [
          const CartIcon(),
          IconButton(
              onPressed: () => Get.to(() => const SearchScreen()),
              icon: const Icon(Icons.search)),
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
    final HomeController homeController = Get.find();
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
        const BrandGrid(),
        const SizedBox(height: 10),
        const HotTopicsSlider(),
        //ClipHereToShop(size: size),
        const SizedBox(height: 15),
        const NewProducts(),
        const SizedBox(height: 20),
        const RowText(left: "RECOMMEND", right: ""),
        const RowText(left: "ITEMRecommended", right: "/ for you"),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeController.mainCategories.length,
          itemBuilder: (context, index) {
            final mainCategory = homeController.mainCategories[index];
            final fId = homeController.firstCategories
                .where((e) => e.parentId == mainCategory.id);
            if (fId.isNotEmpty) {
              final products = homeController.products
                  .where((e) =>
                      e.status == "RECOMMEND" &&
                      fId
                          .where((element) => element.id == e.parentId)
                          .isNotEmpty)
                  .toList();
              if (products.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: ItemRecommended(
                    products: products,
                    title: mainCategory.name,
                  ),
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        ),
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
