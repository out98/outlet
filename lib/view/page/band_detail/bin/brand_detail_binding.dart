import 'package:get/get.dart';
import 'package:outlet/view/page/band_detail/controller/brand_detail_controller.dart';

class BrandDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BrandDetailController());
  }
}
