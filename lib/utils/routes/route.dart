import 'package:get/get.dart';
import 'package:outlet/utils/routes/route_url.dart';
import 'package:outlet/view/page/admin/advertisement/bin/ad_binding.dart';
import 'package:outlet/view/page/admin/advertisement/view/ad_view.dart';
import 'package:outlet/view/page/admin/brand/bin/brand_binding.dart';
import 'package:outlet/view/page/admin/brand/view/brand_view.dart';
import 'package:outlet/view/page/admin/main_category/bin/mc_binding.dart';
import 'package:outlet/view/page/admin/main_category/view/mc_view.dart';
import 'package:outlet/view/page/admin/product/bin/product_binding.dart';
import 'package:outlet/view/page/admin/sub_category/bin/sc_binding.dart';
import 'package:outlet/view/page/admin/sub_category/view/sc_view.dart';
import 'package:outlet/view/page/band_detail/bin/brand_detail_binding.dart';
import 'package:outlet/view/page/band_detail/view/brand_detail_view.dart';
import 'package:outlet/view/page/cart/view/cart_view.dart';
import 'package:outlet/view/page/favourite/favourite_screen.dart';
import 'package:outlet/view/page/home_screen/home_screen.dart';
import 'package:outlet/view/page/order_history/bin/order_history_bindng.dart';
import 'package:outlet/view/page/order_history/order_history.dart';
import 'package:outlet/view/page/product_detail/bin/product_detail_binding.dart';
import 'package:outlet/view/page/product_detail/view/product_detail_view.dart';

import '../../view/page/admin/product/view/manage_product.dart';
import '../../view/page/admin/user_order/user_order_view.dart';

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
  GetPage(
    name: mainCategoryScreen,
    binding: MCBinding(),
    page: () => const MCView(),
  ),
  GetPage(
    name: subCategoryScreen,
    binding: SCBinding(),
    page: () => const SCView(),
  ),
  GetPage(
    name: brandScreen,
    binding: BrandBinding(),
    page: () => const BrandView(),
  ),
  GetPage(
    name: manageProducts,
    binding: ProductBinding(),
    page: () => const ManageProduct(),
  ),
  GetPage(
    name: myCartScreen,
    page: () => const CartView(),
  ),
  GetPage(
    name: orderScreen,
    page: () => const UserOrderView(),
  ),
  GetPage(
    name: purchaseHistory,
    binding: OrderHistoryBinding(),
    page: () => const OrderHistory(),
  ),
  GetPage(
    name: brandDetailScreen,
    binding: BrandDetailBinding(),
    page: () => const BrandDetailView(),
  ),
];
