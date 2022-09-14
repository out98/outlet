import 'package:get/get.dart';
import 'package:outlet/view/page/admin/brand/controller/brand_controller.dart';

class BrandBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BrandController());
  }
}
