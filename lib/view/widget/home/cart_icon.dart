import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/cart_controller.dart';

import '../../../utils/routes/route_url.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.all(0),
      child: InkWell(
        onTap: () => Get.toNamed(myCartScreen),
        child: SizedBox(
          height: 50,
          width: 70,
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Icon(FontAwesomeIcons.cartPlus, size: 30),
              ),
              Positioned(
                top: 20,
                right: 0,
                child: Obx(() {
                  return CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey.shade300,
                    child: Text(
                      controller.myCart.length.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 10),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
