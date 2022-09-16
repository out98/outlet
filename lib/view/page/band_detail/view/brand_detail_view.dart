import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/view/widget/brand_detail/brand_products.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../controller/home_controller.dart';

class BrandDetailView extends StatelessWidget {
  const BrandDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final brand = homeController.editBrand.value;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          brand?.name ?? "",
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          //Brand Image
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
            imageUrl: brand?.image ?? "",
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 5),
          Column(
            children: [
              //Brand Name
              Text(
                brand?.name ?? "",
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 20),
              //Brand Status
              Text(
                brand?.status ?? "",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 15),
              //Brand Description
              Text(brand?.subName ?? "",
                  style: Theme.of(context).textTheme.headline3),
              const SizedBox(height: 15),
            ],
          ),
          //Brand Products
          const BrandDetailProducts(),
        ],
      ),
    );
  }
}
