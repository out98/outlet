import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/product.dart';
import '../../../utils/routes/route_url.dart';
import '../../widget/home/row_text.dart';

class AllNewItems extends StatelessWidget {
  final List<Product> newItems;
  const AllNewItems({Key? key, required this.newItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "All New Items",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          final product = newItems[index];
          final month = product.dateTime.month;
          final day = product.dateTime.day;
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
                    Expanded(
                        child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: CachedNetworkImage(
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
                    )),
                    const SizedBox(height: 15),
                    //Status and Released Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                          width: 55,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              product.status ?? "",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Released on $month/$day",
                          style: const TextStyle(
                            color: Colors.pink,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.name,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                )),
          );
        },
        itemCount: newItems.length,
      ),
    );
  }
}
