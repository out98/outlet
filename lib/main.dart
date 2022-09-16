import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlet/controller/cart_controller.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/model/hive_product.dart';
import 'package:outlet/utils/routes/route.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/utils/themes/theme.dart';

import 'constant/constant.dart';
import 'controller/auth_controller.dart';
import 'model/hive_purchase.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Hive.initFlutter();
  Hive.registerAdapter<HiveProduct>(HiveProductAdapter());
  await Hive.openBox<HiveProduct>(boxName);
  Hive.registerAdapter<HivePurchase>(HivePurchaseAdapter());
  await Hive.openBox<HivePurchase>(purchaseBox);
  Get.put(HomeController());
  Get.put(AuthController());
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: homeScreen,
      theme: AppTheme.lightTheme(),
      getPages: pages,
    );
  }
}
