import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/view/page/admin/advertisement/controller/ad_controller.dart';
import 'package:outlet/view/widget/switch/custon_swich.dart';
import 'package:outlet/view/widget/text_form/image_pick_form.dart';
import 'package:outlet/view/widget/text_form/text_form.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import '../../../../../constant/constant.dart';

class AdView extends StatelessWidget {
  const AdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ADController adController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Center(child: Text("ကြော်ငြာ အုပ်စုများ")),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Form(
          key: adController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /**Form*/
              CustomTextForm(
                padding: 0,
                rightPadding: 40,
                height: 85,
                textFieldPaddingLeft: 10,
                controller: adController.nameController,
                isUnderlineBorder: false,
                validator: adController.validate,
                labelText: "Ad Name",
              ),
              Obx(() {
                final pickedImage = adController.pickedImage.value;
                return ImagePickForm(
                  labelText: pickedImage,
                  pickImage: () => adController.pickImage(),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Hot"),
                        const SizedBox(height: 5),
                        Obx(() {
                          final isHot = adController.isHot.value;
                          return CustomSwitch(
                            value: isHot,
                            onChanged: (value) =>
                                adController.changeIsHot(value),
                          );
                        }),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => adController.save(),
                      child: const Text("Save"),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              /**Advertisement List*/
              Expanded(
                child: Obx(
                  () {
                    if (adController.advertisement.isEmpty) {
                      return const Center(
                          child: Text(
                        "No advertisement yet....",
                      ));
                    }

                    return ListView.builder(
                      itemCount: adController.advertisement.length,
                      itemBuilder: (context, index) {
                        var advertisement = adController.advertisement[index];

                        return SwipeActionCell(
                          key: ValueKey(advertisement.id),
                          trailingActions: [
                            SwipeAction(
                              onTap: (CompletionHandler _) async {
                                await _(true);
                                await adController.delete(advertisement.id);
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
                                      advertisement.name ?? "",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
