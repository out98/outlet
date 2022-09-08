import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/utils/routes/route.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/utils/themes/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(HomeController());
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