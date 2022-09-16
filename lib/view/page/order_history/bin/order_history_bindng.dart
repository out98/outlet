import 'package:get/get.dart';
import 'package:outlet/view/page/order_history/controller/order_history_controller.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderHistoryController());
  }
}
