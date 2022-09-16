import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/cart_controller.dart';

import '../../../constant/constant.dart';

class CustomCheckBox extends StatelessWidget {
  final double height;
  final PaymentOptions options;
  final IconData icon;
  final Color iconColor;
  final String text;
  const CustomCheckBox({
    Key? key,
    required this.height,
    required this.options,
    required this.icon,
    required this.iconColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find();
    return Container(
      padding: EdgeInsets.only(
        left: 20,
      ),
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: InkWell(
        onTap: () {
          //Change Payment Options
          controller.changePaymentOptions(options);
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: 10),
              Obx(() => Text(
                    text,
                    style: TextStyle(
                      color: controller.paymentOptions == options
                          ? Colors.black
                          : Colors.grey,
                    ),
                  )),
            ],
          ),
          Obx(
            () => SizedBox(
              width: 50,
              child: Opacity(
                opacity: controller.paymentOptions == options ? 1 : 0,
                child: Icon(FontAwesomeIcons.check, color: Colors.green),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
