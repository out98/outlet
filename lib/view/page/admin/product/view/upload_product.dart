import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constant/constant.dart';
import '../../../../../controller/home_controller.dart';
import '../../../../widget/text_form/text_form.dart';
import '../../sub_category/view/sc_view.dart';
import '../controller/product_controller.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({Key? key}) : super(key: key);

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  final ProductController productController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    productController.clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homecontroller = Get.find();
    final editProduct = homecontroller.editProduct.value;
    final isEdit = !(editProduct == null);
    final isNew = homecontroller.editProduct.value == null;
    return Scaffold(
        backgroundColor: scaffoldBackground,
        appBar: AppBar(
          title: const Text(
            "TOPVALU",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
              // fontStyle: FontStyle.italic,
              wordSpacing: 2,
              letterSpacing: 3,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: homeIndicatorColor,
                ),
                child: isNew ? const Text("Save") : const Text("Edit"),
                onPressed: () =>
                    isNew ? productController.save() : productController.edit(),
              ),
            ),
          ],
          elevation: 5,
          backgroundColor: detailBackgroundColor,
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Form(
            key: productController.formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  //Name
                  CustomTextForm(
                    padding: 0,
                    height: 85,
                    maxLines: 2,
                    textFieldPaddingLeft: 10,
                    controller: productController.nameController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        productController.validate(value, "Name"),
                    labelText: "Name",
                  ),
                  //Description
                  CustomTextForm(
                    padding: 0,
                    height: 85,
                    keyboaType: TextInputType.multiline,
                    textFieldPaddingLeft: 10,
                    controller: productController.descriptionController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        productController.validate(value, "Description"),
                    labelText: "Description",
                  ),
                  //Features
                  CustomTextForm(
                    maxLines: 1,
                    padding: 0,
                    height: 85,
                    textFieldPaddingLeft: 10,
                    controller: productController.featuresController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        productController.validate(value, "Features"),
                    labelText: "Features(eg- XL,Red)",
                  ),
                  //Price
                  CustomTextForm(
                    padding: 0,
                    height: 85,
                    textFieldPaddingLeft: 10,
                    keyboaType: TextInputType.number,
                    controller: productController.priceController,
                    isUnderlineBorder: false,
                    validator: (value) =>
                        productController.validate(value, "Price"),
                    labelText: "Price",
                    maxLines: 1,
                  ),
                  //Discount (Optional)
                  CustomTextForm(
                    padding: 0,
                    height: 85,
                    textFieldPaddingLeft: 10,
                    keyboaType: TextInputType.number,
                    controller: productController.discountController,
                    isUnderlineBorder: false,
                    labelText:
                        "Discount(Optional),this will become a discount product.",
                    maxLines: 1,
                  ),
                  //Require Point (Optional)
                  CustomTextForm(
                    padding: 0,
                    height: 85,
                    textFieldPaddingLeft: 10,
                    keyboaType: TextInputType.number,
                    controller: productController.requirePointController,
                    isUnderlineBorder: false,
                    labelText:
                        "Points(Optional),this will be a product users must buy with their points.",
                    maxLines: 1,
                  ),
                  Text(
                    "Status:",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),

                  //ChoiceChip Status
                  Wrap(
                    children: statusList.map((e) {
                      return Obx(() {
                        final selected =
                            e == productController.statusType.value;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChoiceChip(
                            label: Text(
                              e,
                              style: TextStyle(
                                color: selected ? Colors.white : Colors.black,
                              ),
                            ),
                            selectedColor: Colors.pink,
                            selected: selected,
                            onSelected: (bool selected) {
                              productController.setStatusType(e);
                            },
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  Text(
                    "Categories & Brands:",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 10),
                  //Category & Brand
                  Row(
                    children: [
                      Obx(() {
                        final selectedValue =
                            productController.selectedSubCategoryName.value;
                        final isEmpty = selectedValue.isEmpty;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: UpDownChoice(
                              items: productController.subCategories,
                              hint: "Select Category",
                              increase: productController.increaseCategory,
                              decrease: productController.decreaseCategory,
                              isEmpty: isEmpty,
                              selectedValue: selectedValue,
                            ),
                          ),
                        );
                      }),
                      Obx(() {
                        final selectedValue =
                            productController.selectedBrandName.value;
                        final isEmpty = selectedValue.isEmpty;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: UpDownChoice(
                              items: productController.brands,
                              hint: "Select Brand",
                              increase: productController.increaseBrand,
                              decrease: productController.decreaseBrand,
                              isEmpty: isEmpty,
                              selectedValue: selectedValue,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Pick images:",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 10),
                  //Images
                  Obx(
                    () {
                      return productController.pickedImage.isEmpty
                          ? Align(
                              alignment: Alignment.bottomLeft,
                              child: AddImage(
                                  productController: productController))
                          : Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: List.generate(
                                        productController.pickedImage.length +
                                            1, (index) {
                                      if (index ==
                                          productController
                                              .pickedImage.length) {
                                        return AddImage(
                                            productController:
                                                productController);
                                      }
                                      final element =
                                          productController.pickedImage[index];
                                      return Card(
                                        child: !(productController.isFile.value)
                                            ? CachedNetworkImage(
                                                imageUrl: element,
                                                memCacheHeight: 80,
                                                memCacheWidth: 80,
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder:
                                                    (context, _, __) {
                                                  return Shimmer.fromColors(
                                                    highlightColor:
                                                        Colors.white,
                                                    baseColor: Colors.grey,
                                                    child: Container(
                                                        color: Colors.white),
                                                  );
                                                },
                                              )
                                            : Card(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  child: Image.file(
                                                    File(element),
                                                    fit: BoxFit.cover,
                                                    height: 80,
                                                    width: 80,
                                                  ),
                                                ),
                                              ),
                                      );
                                    })),
                              ),
                            );
                    },
                  ),
                ],
              ),
            )));
  }
}

class AddImage extends StatelessWidget {
  const AddImage({
    Key? key,
    required this.productController,
  }) : super(key: key);

  final ProductController productController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Card(
        child: InkWell(
            onTap: () => productController.pickImage(),
            child: CachedNetworkImage(
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpNiW6sXgafS6WrknFlr-AVYPRAIVK83NTkA&usqp=CAU",
              memCacheHeight: 80,
              memCacheWidth: 80,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, _, __) {
                return Shimmer.fromColors(
                  highlightColor: Colors.white,
                  baseColor: Colors.grey,
                  child: Container(color: Colors.white),
                );
              },
            )),
      ),
    );
  }
}
