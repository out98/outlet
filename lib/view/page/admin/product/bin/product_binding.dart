import 'package:get/get.dart';
import 'package:outlet/view/page/admin/product/controller/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
  }
}
