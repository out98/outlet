import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/cart_controller.dart';
import 'package:outlet/view/page/checkout/check_out_screen.dart';

import '../../../constant/constant.dart';

Widget nextButton() {
  CartController controller = Get.find();
  return //Next
      Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    child: TextButton(
      onPressed: () {
        if (controller.paymentOptions != PaymentOptions.None) {
          //Go To CheckOut Screen
          Navigator.of(Get.context!).pop();
          Get.to(() => const CheckOutScreen());
        }
      },
      child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 16)),
    ),
  );
}
