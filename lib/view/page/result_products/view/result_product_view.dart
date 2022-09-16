import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/model/filter_enum.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/routes/route_url.dart';

class ResultProductView extends StatelessWidget {
  const ResultProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return ListView(
      children: [
        //Filter 3Functions
        Obx(() {
          debugPrint("*****FilterMainId: ${homeController.filterMainId.value}");
          return FilterWidget<String>(
            value: homeController.filterMainId.value,
            homeController: homeController,
            hint: "Filter by product/feature",
            items: homeController.selectedFirstCategories
                .map((element) => DropdownMenuItem<String>(
                      value: element.id,
                      child: Text(
                        element.name,
                      ),
                    ))
                .toList(),
            onChanged: (value) => homeController.setFilterMainId = value!,
          );
        }),
        Obx(() {
          return FilterWidget<String>(
            value: homeController.filterBrandId.value,
            homeController: homeController,
            hint: "Filter by brand",
            items: homeController.brands
                .map((element) => DropdownMenuItem<String>(
                      value: element.id,
                      child: Text(
                        element.name,
                      ),
                    ))
                .toList(),
            onChanged: (value) => homeController.setFilterBrandId = value!,
          );
        }),
        Obx(() {
          return FilterWidget<FilterEnum>(
            value: homeController.filterEnum.value,
            homeController: homeController,
            hint: "Filter by function",
            items: filter
                .map((element) => DropdownMenuItem<FilterEnum>(
                      value: element.fEnum,
                      child: Text(
                        element.name,
                      ),
                    ))
                .toList(),
            onChanged: (value) => homeController.setFilterEnum = value!,
          );
        }),
        Center(
          child: SizedBox(
            width: 180,
            child: ElevatedButton(
                onPressed: () => homeController.filterFunction(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.search),
                    Text(
                      "search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 8,
                      ),
                    )
                  ],
                )),
          ),
        ),
        //Filter Result Products List
        Obx(() {
          final items = homeController.selectedProducts;
          return items.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final product = items[index];
                    return Container(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            homeController.setSelectedItem = product;
                            Get.toNamed(productDetailScreen);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Hero(
                                  tag: product.image.first,
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
                                ),
                              ),
                              const SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: product.rating ?? 0,
                                        itemSize: 20,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 10,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      const SizedBox(width: 5),
                                      Text("${product.rating ?? 0}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${product.price} MMK",
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    product.description,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                  itemCount: items.length,
                )
              : const Center(
                  child: Text(
                  "Result products not found.....",
                ));
        }),
      ],
    );
  }
}

class FilterWidget<T> extends StatelessWidget {
  final String hint;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final T? value;
  const FilterWidget({
    Key? key,
    required this.homeController,
    required this.hint,
    required this.items,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 2,
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: DropdownButton(
            value: value,
            isExpanded: true,
            hint: Text(
              hint,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            alignment: Alignment.center,
            elevation: 0,
            iconSize: 25,
            icon: Container(
              color: Colors.grey.shade300,
              padding: const EdgeInsets.all(12),
              child: const Icon(
                FontAwesomeIcons.chevronDown,
                color: Colors.grey,
              ),
            ),
            underline: const SizedBox(),
            style: Theme.of(context).textTheme.subtitle1,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
