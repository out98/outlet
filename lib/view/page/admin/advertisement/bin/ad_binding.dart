import 'package:get/get.dart';
import 'package:outlet/view/page/admin/advertisement/controller/ad_controller.dart';

class ADBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ADController());
  }
}
