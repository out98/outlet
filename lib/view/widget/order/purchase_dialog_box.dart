import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Condition;
import 'package:outlet/view/widget/order/user_order_print_view.dart';

import '../../../constant/constant.dart';
import '../../../controller/home_controller.dart';
import '../../../model/purchase.dart';

Widget purchaseDialogBox({
  required PurchaseModel purchaseModel,
  required BuildContext context,
}) {
  HomeController controller = Get.find();
  final responsiveFontSize14 = TextStyle(
    fontSize: 10,
  );
  final responsiveFontSize10 = TextStyle(
    fontSize: 6,
  );
  final total =
      purchaseModel.total - purchaseModel.deliveryTownshipInfo[1] as int;
  final township = purchaseModel.deliveryTownshipInfo[0];
  final shipping = purchaseModel.deliveryTownshipInfo[1];
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Purchase Date"),
          Text(
            "၀ယ်ယူခဲ့သော နေ့ရက် - ${DateTime.tryParse(purchaseModel.dateTime)?.day}/${DateTime.tryParse(purchaseModel.dateTime)?.month}/${DateTime.tryParse(purchaseModel.dateTime)?.year}",
            style: responsiveFontSize14,
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Name"),
          Text(
            purchaseModel.name,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Ph No."),
          Text(
            "0${purchaseModel.phone}",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Email"),
          Text(
            purchaseModel.email,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text("Address"),
          Expanded(
              child: Text(
            purchaseModel.address,
            style: TextStyle(fontSize: 14),
          )),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          itemCount: purchaseModel.items.length,
          itemBuilder: (_, o) {
            final purchase = purchaseModel.items[o];
            return Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${o + 1}. ${purchase.name}",
                      style: TextStyle(fontSize: 12),
                      maxLines: null,
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Text(
                      "${purchase.features}",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  if (purchase.discountPrice! > 0) ...[
                    Text(
                      "${purchase.discountPrice} x  ${purchase.count} ထည်",
                      style: TextStyle(fontSize: 10),
                    ),
                  ] else if (purchase.requirePoint! > 0) ...[
                    Text(
                      "${purchase.requirePoint} x  ${purchase.count} ထည်",
                      style: TextStyle(fontSize: 10),
                    ),
                  ] else ...[
                    Text(
                      "${purchase.price} x  ${purchase.count} ထည်",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ],
              ),
            );
          }),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ပို့ဆောင်ရမည့်မြို့နယ် -",
            style: responsiveFontSize14,
          ),
          //SizedBox(width: 10),
          Text(
            township,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "စုစုပေါင်း",
            style: responsiveFontSize14,
          ),
          Text(
            "($total) + Deli $shipping Ks",
            style: responsiveFontSize14,
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: homeIndicatorColor,
        ),
        onPressed: () {
          //Show BlueTooth Dialog..Box....
          Get.to(() => UserOrderPrintView(
                purchaseModel: purchaseModel,
                total: total,
                shipping: shipping,
                township: township,
              ));
        },
        child: Text("Print Preview"),
      ),
    ],
  );
}
