import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/view/page/all_new_items/all_new_items_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/mock.dart';
import '../../../utils/routes/route_url.dart';
import 'row_text.dart';

class NewProducts extends StatelessWidget {
  const NewProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Obx(() {
      final newProducts =
          homeController.products.where((e) => e.status == "NEW").toList();
      return newProducts.isNotEmpty
          ? Container(
              color: Colors.amber.shade100,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const RowText(left: "NEW ITEMNew", right: "/ product"),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      final product = newProducts[index];
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
                                    progressIndicatorBuilder:
                                        (context, url, status) {
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
                                              color: Colors.white,
                                              fontSize: 10),
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
                    itemCount: newProducts.length,
                  ),
                  const SizedBox(height: 20),
                  //See All
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () =>
                          Get.to(() => AllNewItems(newItems: newProducts)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.pink,
                          ),
                          const SizedBox(width: 10),
                          Text("See the list",
                              style: Theme.of(context).textTheme.subtitle1)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ))
          : const SizedBox();
    });
  }
}
