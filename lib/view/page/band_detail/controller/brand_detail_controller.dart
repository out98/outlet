import 'package:get/get.dart';
import 'package:outlet/model/product.dart';

import '../../../../controller/home_controller.dart';

class BrandDetailController extends GetxController {
  final HomeController homeController = Get.find();
  RxList<Product> brandProducts = <Product>[].obs;

  @override
  void onInit() {
    brandProducts.value = homeController.products
        .where((e) => e.brandId == homeController.editBrand.value!.id)
        .toList();
    super.onInit();
  }
}
