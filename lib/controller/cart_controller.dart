import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:outlet/controller/auth_controller.dart';
import 'package:outlet/model/hive_item.dart';
import 'package:outlet/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../constant/constant.dart';
import '../model/hive_purchase.dart';
import '../model/purchase.dart';
import '../service/database.dart';
import '../view/widget/show_loading/show_loading.dart';

class CartController extends GetxController {
  final database = Database();
  final RxMap<String, List<dynamic>> myCart = <String, List<dynamic>>{}.obs;
  Map<String, dynamic> townShipNameAndFee = {};
  final AuthController authControler = Get.find();
  var firstTimePressedCart = false.obs;
  var bankSlipImage = "".obs;
  var checkOutStep = 0.obs;
  var paymentOptions = PaymentOptions.None.obs;
  int mouseIndex = -1; //Mouse Region
  Box<HivePurchase> purchaseHiveBox = Hive.box(purchaseBox);
  void addCount(Product product) {
    if (myCart.containsKey(product.id)) {
      var previousCount = myCart[product.id]![0] as int;
      myCart[product.id] = [previousCount + 1, product];
    } else {
      myCart.putIfAbsent(product.id, () => [1, product]);
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

  bool checkToAcceptOrder() {
    if (myCart.isEmpty) {
      Get.snackbar('Error', "Cart is empty");
      return false;
    } else if (townShipNameAndFee.isEmpty) {
      Get.snackbar('Error', "Need to choose a township");
      firstTimePressedCart.value = true;
      return false;
    } else {
      return true;
    }
  }

  void changeMouseIndex(int i) {
    // Change Mouse Region
    mouseIndex = i;
    debugPrint("On Mouse Exist************");
    update();
  }

  String? townshipName;
  void setTownshipName(String? val) {
    townshipName = val!;
    update();
  }

  void setTownShipNameAndShip({required String name, required String fee}) {
    townShipNameAndFee = {
      "townName": name,
      "fee": int.parse(fee),
    };
    update();
  }

  void changePaymentOptions(PaymentOptions option) {
    paymentOptions.value = option;
  }

  //Change Step Index
  void changeStepIndex(int value) {
    checkOutStep.value = value;
  }

  //Set Bank Slip Image
  void setBankSlipImage(String image) {
    bankSlipImage.value = image;
  }

  List<String> getUserOrderData() {
    return sharedPref.getStringList("userOrder") ?? [];
  }

  //Set User's Order Data or Not
  Future<void> setUserOrderData({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    //Making Purchase Model
    try {} catch (e) {}
    final list = getUserOrderData();
    //Check data already contain with the same data inside SharedPreference
    if (list.isEmpty) {
      await sharedPref
          .setStringList("userOrder", [name, email, phone, address]);
    } else if ( //Something is changed by User,then we restore
        (name != list[0]) ||
            (email != list[1]) ||
            (phone != list[2]) ||
            (address != list[3])) {
      await sharedPref
          .setStringList("userOrder", [name, email, phone, address]);
    }
  }

  late SharedPreferences sharedPref;
  @override
  void onInit() async {
    sharedPref = await SharedPreferences.getInstance();
    if (getUserOrderData().isNotEmpty) {
      checkOutStep.value = 1;
    }
    super.onInit();
  }

  Future<void> proceedToPay() async {
    showLoading();
    final total = subTotal + townShipNameAndFee["fee"] as int;
    try {
      final list = getUserOrderData();
      final _purchase = PurchaseModel(
        total: total,
        dateTime: DateTime.now().toString(),
        id: Uuid().v1(),
        items: myCart.entries.map((e) {
          final product = e.value[1] as Product;
          final count = e.value[0] as int;
          return product.copyWith(
            image: [product.image.first],
            description: "",
            count: count,
          );
        }).toList(),
        name: list[0],
        email: list[1],
        phone: list[2],
        address: list[3],
        bankSlipImage: bankSlipImage.value.isEmpty ? null : bankSlipImage.value,
        deliveryTownshipInfo: [
          townShipNameAndFee["townName"],
          townShipNameAndFee["fee"]
        ],
      );
      final hivePurchase = HivePurchase(
        id: Uuid().v1(),
        items: _purchase.items
            .map((e) => HiveItem(
                  id: e.id,
                  name: e.name,
                  features: e.features ?? "",
                  image: e.image.first,
                  price: e.price,
                  dicountPrice: e.discountPrice ?? 0,
                  requirePoints: e.requirePoint ?? 0,
                  count: e.count!,
                ))
            .toList(),
        totalPrice: total,
        deliveryTownshipInfo: _purchase.deliveryTownshipInfo,
        dateTime: DateTime.now(),
      );
      await database.writePurchaseData(_purchase).then((value) {
        hideLoading();
        Get.back();
        Get.snackbar("လူကြီးမင်း Order တင်ခြင်း", 'အောင်မြင်ပါသည်');
        clearAll();
        purchaseHiveBox.put(hivePurchase.id, hivePurchase);
      });
    } catch (e) {
      hideLoading();
      Get.snackbar("လူကြီးမင်း Order တင်ခြင်း", 'မအောင်မြင်ပါ');
      print("proceed to pay error $e");
    }
  }

  void clearAll() {
    myCart.clear();
    subTotal = 0;
    townshipName = "";
    townShipNameAndFee = {};
    paymentOptions = PaymentOptions.None.obs;
    bankSlipImage = "".obs;
    firstTimePressedCart = false.obs;
  }
}
