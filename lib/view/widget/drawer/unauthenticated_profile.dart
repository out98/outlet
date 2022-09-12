import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';

class UnAuthenticatedProfile extends StatelessWidget {
  const UnAuthenticatedProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Column(
      children: [
        //Name
        Text(
          "Guest".toUpperCase(),
          style: Theme.of(context).textTheme.headline3,
        ),
        //LogOut
        TextButton(
          onPressed: () => authController.googleSingIn(),
          child: Text(
            "LOG IN".toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
