import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/utils/routes/route.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/utils/themes/theme.dart';

void main() {
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