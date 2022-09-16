import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/cart_controller.dart';

import '../../../model/division.dart';

Widget townShipDialog({required Division division}) {
  CartController controller = Get.find();
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: 400,
      height: MediaQuery.of(Get.context!).size.height,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(),
          bottom: BorderSide(),
          left: BorderSide(),
          right: BorderSide(),
        ),
        color: Colors.white,
      ),
      child: ListView(
        children: division.townShipMap.entries.map((map) {
          return SizedBox(
            height: map.value.length * 50,
            child: ListView.builder(
                primary: false,
                itemCount: map.value.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      controller.setTownShipNameAndShip(
                        name: map.value[index],
                        fee: map.key,
                      );
                      //Pop this dialog
                      Get.back();
                      Get.back();
                    },
                    child: Text(
                      map.value[index],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  );
                }),
          );
        }).toList(),
      ),
    ),
  );
}
