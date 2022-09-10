import 'package:get/get.dart';

class AppDrawerController extends GetxController {
  var selectedDrawerItem = "";
  var selectedMainCategory = "";
  var selectedMainId = "";
  var selectedFirstCategory = "";
  var selectedFirstId = "";

  void setSelectedDrawerItem(String value) {
    selectedDrawerItem = value;
  }

  void setSelectedMainCategory(List<String> value) {
    selectedMainCategory = value[0];
    selectedMainId = value[1];
  }

  void setSelectedFirstCategory(List<String> value) {
    selectedFirstCategory = value[0];
    selectedMainId = value[1];
  }
}
