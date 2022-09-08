import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/model/product.dart';

class PSCController extends GetxController{
  final HomeController _homeController = Get.find();
  final List<Product> products = [];

  @override
  void onInit() {
    super.onInit();
  }

  //find products from selected category
  void findProducts(String categoryID){

  }
}