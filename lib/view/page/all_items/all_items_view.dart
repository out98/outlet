import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/routes/route_url.dart';

class AllItemsView extends StatelessWidget {
  const AllItemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "All Items",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = homeController.products[index];
          return InkWell(
            onTap: () {
              homeController.setSelectedItem = product;
              Get.toNamed(productDetailScreen);
            },
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, status) {
                        return Shimmer.fromColors(
                          child: Container(
                            color: Colors.white,
                          ),
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                        );
                      },
                      errorWidget: (context, url, whatever) {
                        return const Text("Image not available");
                      },
                      imageUrl: product.image.first,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      product.name,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                )),
          );
        },
        itemCount: homeController.products.length,
      ),
    );
  }
}
