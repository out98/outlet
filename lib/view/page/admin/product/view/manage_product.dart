import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/view/page/admin/product/controller/product_controller.dart';
import 'package:outlet/view/page/admin/product/view/upload_product.dart';

import '../../../../../constant/constant.dart';
import '../../../../../controller/home_controller.dart';

class ManageProduct extends StatelessWidget {
  const ManageProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    final HomeController homeController = Get.find();
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
        elevation: 0,
        backgroundColor: detailBackgroundColor,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: homeIndicatorColor,
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: () {
          homeController.setEditProduct = null;
          Get.to(() => const UploadProduct());
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: productController.editingController,
              onChanged: (value) => productController.onSearch(value),
              // onSubmitted: homeController.searchItem,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Search",
                  suffixIcon: IconButton(
                    onPressed: () => productController.clearSearch(),
                    icon: const Icon(Icons.clear),
                  )),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: productController.isSearch.value
                      ? productController.searchItems.length
                      : productController.products.length,
                  itemBuilder: (_, i) {
                    final item = productController.isSearch.value
                        ? productController.searchItems[i]
                        : productController.products[i];
                    return SwipeActionCell(
                      key: ValueKey(item.id),
                      trailingActions: [
                        SwipeAction(
                          onTap: (CompletionHandler _) async {
                            await _(true);
                            await productController.delete(item.id);
                          },
                          title: 'Delete',
                        ),
                        SwipeAction(
                          color: Colors.grey,
                          onTap: (CompletionHandler _) async {
                            await _(false);
                            homeController.setEditProduct = item;
                            productController.configureForEditProduct(item);
                            Get.to(() => const UploadProduct());
                          },
                          title: 'Edit',
                        ),
                      ],
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 140,
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: item.image.first,
                                width: 100,
                                height: 125,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      item.features ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        wordSpacing: 1,
                                      ),
                                    ),
                                    Text(
                                      "${item.price}Ks",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
