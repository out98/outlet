import 'package:get/get.dart';
import 'package:outlet/view/page/admin/main_category/controller/mc_controller.dart';

import '../controller/sc_controller.dart';

class SCBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SCController());
  }
}
