import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/constant/mock.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/view/widget/custom_carousel.dart';
import 'package:shimmer/shimmer.dart';

import 'row_text.dart';

class HotTopicsSlider extends StatelessWidget {
  const HotTopicsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final HomeController homeController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Obx(() {
        final products = homeController.advertisement;
        final hots = products.where((e) => e.isHot == true).toList();
        final isNotEmpty = hots.isNotEmpty;
        return isNotEmpty
            ? Column(
                children: [
                  const RowText(
                      left: "HOT TOPICSrecommended", right: "/ information"),
                  const SizedBox(height: 10),
                  CustomCarousel(
                    enlargeMainPage: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    aspectRatio: 8 / 4,
                    autoPlay: true,
                    viewportFraction: 0.8,
                    hasPagination: true,
                    pagerSize: 12,
                    activeIndicator: Colors.pink,
                    passiveIndicator: Colors.grey.shade300,
                    autoPlayInterval: const Duration(seconds: 6),
                    items: hots.map((advertisement) {
                      return Column(
                        children: [
                          Expanded(
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
                              imageUrl: advertisement.image,
                              fit: BoxFit.contain,
                              /*  height: 150,
                                width: width, */
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            advertisement.name ?? "",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              )
            : const SizedBox();
      }),
    );
  }
}
