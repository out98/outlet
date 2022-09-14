import 'package:get/get.dart';
import 'package:outlet/view/page/admin/main_category/controller/mc_controller.dart';

class MCBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MCController());
  }
}
