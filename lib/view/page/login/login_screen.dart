import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //AppLogo
              Image(
                  image: const AssetImage("assets/logo.png"),
                  fit: BoxFit.contain,
                  frameBuilder: (context, widget, _, __) {
                    return CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 99,
                        backgroundColor: Colors.white,
                        child: widget,
                      ),
                    );
                  }),
              /* Builder(
                builder: (context) {
                  return const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 99,
                      backgroundImage: AssetImage("assets/logo.png"),
                    ),
                  );
                }
              ), */

              //AppName
              Text(
                "Outlet".toUpperCase(),
                style: GoogleFonts.irishGrover(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Signin
              Text(
                "Sign in".toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: 18,
                    ),
              ),
              //With
              Text(
                "with".toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: 10,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Google
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    authController.googleSingIn();
                  },
                  child: Text(
                    "Google",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Apple
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    //TODO
                  },
                  child: Text(
                    "Apple",
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
