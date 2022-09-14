import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:outlet/view/page/admin/brand/controller/brand_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constant/constant.dart';
import '../../../../widget/text_form/image_pick_form.dart';
import '../../../../widget/text_form/text_form.dart';

class BrandView extends StatelessWidget {
  const BrandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BrandController brandController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Center(child: Text("Brands")),
      ),
      body: Form(
        key: brandController.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /**Form*/
                CustomTextForm(
                  padding: 0,
                  rightPadding: 20,
                  height: 85,
                  textFieldPaddingLeft: 10,
                  controller: brandController.nameController,
                  isUnderlineBorder: false,
                  validator: (value) => brandController.validate(value, "Name"),
                  labelText: "Brand Name",
                ),
                CustomTextForm(
                  padding: 0,
                  rightPadding: 20,
                  height: 85,
                  textFieldPaddingLeft: 10,
                  controller: brandController.subNameController,
                  isUnderlineBorder: false,
                  validator: (value) =>
                      brandController.validate(value, "Description"),
                  labelText: "Descriptionm",
                ),
                CustomTextForm(
                  padding: 0,
                  rightPadding: 20,
                  height: 85,
                  textFieldPaddingLeft: 10,
                  controller: brandController.statusController,
                  isUnderlineBorder: false,
                  validator: (value) =>
                      brandController.validate(value, "Status"),
                  labelText: "Status",
                ),
                Obx(() {
                  final pickedImage = brandController.pickedImage.value;
                  final isEmpty = pickedImage.isEmpty;
                  return ImagePickForm(
                    labelText: isEmpty ? "pick an image" : pickedImage,
                    pickImage: () => brandController.pickImage(),
                  );
                }),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => brandController.save(),
                      child: const Text("Save"),
                    )),
                const SizedBox(height: 15),
                /**Advertisement List*/
                Obx(
                  () {
                    if (brandController.brands.isEmpty) {
                      return const Center(
                          child: Text(
                        "No brands yet....",
                      ));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: brandController.brands.length,
                      itemBuilder: (context, index) {
                        var advertisement = brandController.brands[index];

                        return SwipeActionCell(
                          key: ValueKey(advertisement.id),
                          trailingActions: [
                            SwipeAction(
                              onTap: (CompletionHandler _) async {
                                await _(true);
                                await brandController.delete(advertisement.id);
                              },
                              content: Container(
                                color: Colors.red,
                                height: 35,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "DELETE",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ],
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 50,
                              maxHeight: 100,
                            ),
                            child: Card(
                              child: Row(
                                children: [
                                  //Advertisement IMAGE
                                  Expanded(
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, status) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey,
                                          highlightColor: Colors.white,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, whatever) {
                                        return const Text(
                                            "Image not available");
                                      },
                                      imageUrl: advertisement.image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  //Type
                                  Expanded(
                                    child: Text(
                                      advertisement.name,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
