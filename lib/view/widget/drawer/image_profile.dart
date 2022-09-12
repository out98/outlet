import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/auth_controller.dart';

class ImageProfile extends StatelessWidget {
  const ImageProfile({
    Key? key,
    required this.authController,
  }) : super(key: key);

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CachedNetworkImage(
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            radius: 50,
            backgroundColor: Colors.pink,
            child: CircleAvatar(
              radius: 48,
              backgroundImage: imageProvider,
            ),
          );
        },
        progressIndicatorBuilder: (context, url, status) {
          return Shimmer.fromColors(
            // ignore: sort_child_properties_last
            child: const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
            ),
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
          );
        },
        errorWidget: (context, url, whatever) {
          return const Text("Image not available");
        },
        imageUrl: authController.currentUser.value!.image,
        fit: BoxFit.cover,
      );
    });
  }
}
