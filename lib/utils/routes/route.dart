import 'package:get/get.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/view/page/home_screen/home_screen.dart';

List<GetPage> pages = [
  GetPage(
    name: homeScreen, 
    page: () => const HomeScreen(),
  )
];