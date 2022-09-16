import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/constant/constant.dart';
import 'package:outlet/controller/cart_controller.dart';
import 'package:outlet/view/widget/cart/township_dialog.dart';

import '../../../constant/township_list.dart';
import '../../../controller/home_controller.dart';

Widget divisionDialogWidget() {
  return Material(
    type: MaterialType.transparency,
    child: Align(
      alignment: Alignment.center,
      child: GetBuilder<CartController>(builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(),
              bottom: BorderSide(),
              left: BorderSide(),
              right: BorderSide(),
            ),
          ),
          width: 250,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: divisionList.length,
              itemBuilder: (context, divisionIndex) {
                return MouseRegion(
                  onHover: (event) {
                    controller.changeMouseIndex(divisionIndex);
                    showDialog(
                      context: context,
                      barrierColor: Colors.white.withOpacity(0),
                      builder: (context) {
                        return townShipDialog(
                            division: divisionList[divisionIndex]);
                      },
                    );
                  },
                  onExit: (event) {
                    controller.changeMouseIndex(0);
                    Navigator.of(context).pop();
                  },
                  child: AnimatedContainer(
                    color: controller.mouseIndex == divisionIndex
                        ? homeIndicatorColor
                        : Colors.white,
                    duration: const Duration(milliseconds: 200),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Text
                          Text(
                            divisionList[divisionIndex].name,
                            style: TextStyle(
                              color: controller.mouseIndex == divisionIndex
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(FontAwesomeIcons.angleRight),
                        ]),
                  ),
                );
              },
            ),
          ),
        );
      }),
    ),
  );
}
