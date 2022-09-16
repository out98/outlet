import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';

import '../../../model/product.dart';

class SearchController extends GetxController {
  final HomeController homeController = Get.find();
  final RxList<Product> searchItems = <Product>[].obs;
  var isSearch = false.obs;
  void onSearch(String name) {
    isSearch.value = true;
    searchItems.value = homeController.products
        .where((p0) => p0.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}
