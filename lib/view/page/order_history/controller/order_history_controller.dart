import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  var purchaseId = "".obs;

  void setPurchaseId(String value) {
    purchaseId.value = value;
  }
}
