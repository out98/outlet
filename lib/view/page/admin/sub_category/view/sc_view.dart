import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/view/page/admin/sub_category/controller/sc_controller.dart';

import '../../../../../constant/constant.dart';
import '../../../../widget/text_form/text_form.dart';

class SCView extends StatelessWidget {
  const SCView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SCController scController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Center(child: Text("Main Categories")),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Form(
          key: scController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /**Form*/
              CustomTextForm(
                padding: 0,
                rightPadding: 40,
                height: 85,
                textFieldPaddingLeft: 10,
                controller: scController.nameController,
                isUnderlineBorder: false,
                validator: scController.validate,
                labelText: "Ad Name",
              ),
              Obx(() {
                return UpDownChoice(
                  items: scController.mainCategories,
                  hint: "Select Main Category",
                  increase: scController.increaseIndex,
                  decrease: scController.decreaseIndex,
                  isEmpty: scController.selectedParentId.isEmpty,
                  selectedValue: scController.selectedParentId.value,
                );
              }),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 40,
                  ),
                  child: ElevatedButton(
                    onPressed: () => scController.save(),
                    child: const Text("Save"),
                  )),
              const SizedBox(height: 15),
              /**Advertisement List*/
              Expanded(
                child: Obx(
                  () {
                    if (scController.subCatgories.isEmpty) {
                      return const Center(
                          child: Text(
                        "No sub categories yet....",
                      ));
                    }

                    return ListView.builder(
                      itemCount: scController.subCatgories.length,
                      itemBuilder: (context, index) {
                        var subCategory = scController.subCatgories[index];

                        return SwipeActionCell(
                          key: ValueKey(subCategory.id),
                          trailingActions: [
                            SwipeAction(
                              onTap: (CompletionHandler _) async {
                                await _(true);
                                await scController.delete(subCategory.id);
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
                              maxHeight: 80,
                            ),
                            child: Card(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    subCategory.name,
                                  ),
                                  Text(
                                    scController.getMainCategory(
                                      subCategory.parentId,
                                    ),
                                  ),
                                ],
                              ),
                            )),
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

class UpDownChoice<T> extends StatelessWidget {
  const UpDownChoice({
    Key? key,
    required this.items,
    required this.hint,
    required this.increase,
    required this.decrease,
    required this.isEmpty,
    required this.selectedValue,
  }) : super(key: key);

  final List<T> items;
  final String selectedValue;
  final void Function() increase;
  final void Function() decrease;
  final String hint;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          //Text
          Expanded(
            child: Text(isEmpty ? hint : selectedValue,
                style: isEmpty
                    ? const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      )),
          ),
          SizedBox(
            height: 50,
            child: Column(
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: decrease,
                    icon: const Icon(
                      FontAwesomeIcons.chevronUp,
                      size: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: increase,
                    icon: const Icon(
                      FontAwesomeIcons.chevronDown,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          )
          //Up & Down button
        ],
      ),
    );
  }
}
