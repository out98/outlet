import 'package:get/get.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/view/page/home_screen/home_screen.dart';
import 'package:outlet/view/page/product_detail/view/product_detail_view.dart';

List<GetPage> pages = [
  GetPage(
    name: homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: productDetailScreen,
    page: () => const DetailScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 300),
  )
];
