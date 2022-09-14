import 'package:get/get.dart';
import 'package:outlet/model/product.dart';

class CartController extends GetxController {
  final RxMap<String, List<dynamic>> myCart = <String, List<dynamic>>{}.obs;

  void addCount(Product product) {
    if (myCart.containsKey(product.id)) {
      var previousCount = myCart[product.id]![0] as int;
      myCart[product.id] = [previousCount + 1, product];
    }
    update([myCart]);
    updateSubTotal(true);
  }

  void reduceCount(Product p) {
    final previousCount = myCart[p.id]![0] as int;
    if (previousCount > 0) {
      myCart[p.id] = [previousCount - 1, p];
    } else {
      myCart.remove(p.id);
    }
    updateSubTotal(true);
  }

  int subTotal = 0;
  var promotionObxValue = 0.obs;
  void updateSubTotal(bool isUpdate) {
    if (subTotal != 0) {
      subTotal = 0;
    }
    int price = 0;
    for (var list in myCart.values) {
      final item = list[1] as Product;
      final count = list[0] as int;
      if (item.discountPrice! > 0) {
        //-----for discount products----//
        price += item.discountPrice! * count;
      } else if (!(item.requirePoint! > 0)) {
        //---for normal products----//
        price += item.price * count;
      }
    }
    subTotal = price;
    if (isUpdate) {
      update();
    }
  }
}
