import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';

class AuthenticatedProfile extends StatelessWidget {
  const AuthenticatedProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Column(
      children: [
        //Name
        Obx(() {
          return Text(
            authController.currentUser.value!.userName.toUpperCase(),
            style: Theme.of(context).textTheme.headline3,
          );
        }),
        const SizedBox(
          height: 10,
        ),
        //-----Point For Admin To Test On Their Own----//
        Obx(
          () => Text(
            "Your points: ${authController.currentUser.value!.points}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //LogOut
        TextButton(
          onPressed: () => authController.logOut(),
          child: Text(
            "LOG OUT".toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        //Delete
        TextButton(
          onPressed: () => authController.delete(),
          child: Text(
            "DELETE ACCOUNT",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
