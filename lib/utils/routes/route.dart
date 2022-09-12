import 'package:get/get.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/view/page/admin/advertisement/bin/ad_binding.dart';
import 'package:outlet/view/page/admin/advertisement/view/ad_view.dart';
import 'package:outlet/view/page/favourite/favourite_screen.dart';
import 'package:outlet/view/page/home_screen/home_screen.dart';
import 'package:outlet/view/page/product_detail/bin/product_detail_binding.dart';
import 'package:outlet/view/page/product_detail/view/product_detail_view.dart';

List<GetPage> pages = [
  GetPage(
    name: homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: productDetailScreen,
    page: () => const DetailScreen(),
    binding: ProductDetailBinding(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 300),
  ),
  GetPage(
    name: favouriteScreen,
    page: () => const FavouriteView(),
  ),
  GetPage(
    name: advertisementScreen,
    binding: ADBinding(),
    page: () => const AdView(),
  ),
];
