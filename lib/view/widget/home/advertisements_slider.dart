import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outlet/constant/mock.dart';
import 'package:outlet/view/widget/custom_carousel.dart';
import 'package:shimmer/shimmer.dart';

class AdvertisementsSlider extends StatelessWidget {
  const AdvertisementsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: CustomCarousel(
        height: 200,
        scrollPhysics: const BouncingScrollPhysics(),
        aspectRatio: 16 / 9,
        autoPlay: true,
        viewportFraction: 1.0,
        hasPagination: true,
        pagerSize: 12,
        activeIndicator: Colors.pink,
        passiveIndicator: Colors.grey.shade300,
        autoPlayInterval: const Duration(seconds: 6),
        items: advertisements.map((advertisement) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
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
                  fit: BoxFit.fill,
                  height: 200,
                  width: width,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
