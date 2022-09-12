import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/model/hive_product.dart';
import 'package:outlet/utils/routes/route.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/utils/themes/theme.dart';

import 'constant/constant.dart';
import 'controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter<HiveProduct>(HiveProductAdapter());
  await Hive.openBox<HiveProduct>(boxName);
  Get.put(HomeController());
  Get.put(AuthController());
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
