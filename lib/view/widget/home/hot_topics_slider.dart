import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outlet/constant/mock.dart';
import 'package:outlet/view/widget/custom_carousel.dart';
import 'package:shimmer/shimmer.dart';

class HotTopicsSlider extends StatelessWidget {
  const HotTopicsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return  Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CustomCarousel(
              enlargeMainPage: true,
              scrollPhysics: const BouncingScrollPhysics(),
              aspectRatio: 8 / 4,
              autoPlay: true,
              viewportFraction: 0.8,
              hasPagination: true,
              pagerSize: 12,
              activeIndicator:Colors.pink, 
              passiveIndicator:  Colors.grey.shade300,
              autoPlayInterval: const Duration(seconds: 6),
              items: hotTopics.map((advertisement) {
                return SingleChildScrollView(
                  child: Column(
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
                              imageUrl: advertisement.image,
                              fit: BoxFit.fill,
                              height: 150,
                              width: width,
                            ),
                    const SizedBox(height: 5),
                    Text(
                        advertisement.name ?? "",
                        style: Theme.of(context).textTheme
                        .subtitle1,
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
  }
}
