import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/utils/routes/route_url.dart';

import '../../../constant/mock.dart';
import 'row_text.dart';

class BrandGrid extends StatelessWidget {
  const BrandGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Obx(() {
      return homeController.brands.isNotEmpty
          ? Column(
              children: [
                const RowText(left: "BRANDBrand", right: "/ information"),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final brand = homeController.brands[index];
                    final isRight = (index + 1) % 4 == 0;
                    final isLeft = (index + 1) % 4 == 1;
                    final middleLeft = (index + 1) % 4 == 2;
                    final last4 = homeController.brands.length - 4;
                    final last4Container = index == last4 || index > last4;
                    return InkWell(
                      onTap: () {
                        homeController.setEditBrand = brand;
                        Get.toNamed(brandDetailScreen);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: isRight || isLeft
                                  ? Border(
                                      bottom: BorderSide(
                                          color: last4Container
                                              ? Colors.grey
                                              : Colors.transparent),
                                    )
                                  : (middleLeft
                                      ? Border(
                                          bottom: BorderSide(
                                              color: last4Container
                                                  ? Colors.grey
                                                  : Colors.transparent),
                                          left: const BorderSide(
                                              color: Colors.grey),
                                        )
                                      : Border(
                                          left: const BorderSide(
                                              color: Colors.grey),
                                          right: const BorderSide(
                                              color: Colors.grey),
                                          bottom: BorderSide(
                                              color: last4Container
                                                  ? Colors.grey
                                                  : Colors.transparent),
                                        ))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Image.network(brand.image)),
                              Text(
                                brand.subName,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Text(
                                    brand.name,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    brand.status,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ],
                          )),
                    );
                  },
                  itemCount: homeController.brands.length,
                ),
              ],
            )
          : const SizedBox();
    });
  }
}
