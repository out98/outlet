import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/view/page/all_items/all_items_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/mock.dart';
import '../../../controller/home_controller.dart';
import '../../../utils/routes/route_url.dart';
import 'row_text.dart';

class FeatureListProductInformation extends StatelessWidget {
  const FeatureListProductInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Obx(() {
      return homeController.products.isNotEmpty
          ? Column(
              children: [
                const SizedBox(height: 10),
                const RowText(
                    left: "PRODUCT",
                    right: "/ Feature List/Product Information"),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                  itemCount: 6,
                ),
                //See All
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const RoundedRectangleBorder(),
                    ),
                    onPressed: () => Get.to(() => const AllItemsView()),
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
            )
          : const SizedBox();
    });
  }
}
