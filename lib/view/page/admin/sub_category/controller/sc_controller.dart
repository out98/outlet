import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/model/first_sub_category.dart';
import 'package:outlet/model/main_category.dart';
import 'package:uuid/uuid.dart';
import '../../../../../service/database.dart';
import '../../../../widget/show_loading/show_loading.dart';

class SCController extends GetxController {
  final HomeController homeController = Get.find();
  final _database = Database();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<FirstSubCategory> subCatgories = <FirstSubCategory>[].obs;
  final RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  var selectedParentId = "".obs;
  var currentIndex = 0.obs;
  final TextEditingController nameController = TextEditingController();
  void setSelectedParentId(String value) => selectedParentId.value = value;
  String? validate(String? value) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "Name is required";
    }
  }

  void clearAll() {
    nameController.clear();
  }

  String getMainCategory(String id) =>
      mainCategories.where((e) => e.id == id).first.name;

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: firstCategoriesCollection,
      documentPath: id,
    );
  }

  Future<void> save() async {
    showLoading();
    if (formKey.currentState?.validate() == true) {
      try {
        final ad = FirstSubCategory(
          id: Uuid().v1(),
          name: nameController.text,
          parentId: mainCategories
              .where((e) => e.name == selectedParentId.value)
              .first
              .id,
          dateTime: DateTime.now(),
        );
        await _database.write(
          collectionPath: firstCategoriesCollection,
          documentPath: ad.id,
          data: ad.toJson(),
        );
        clearAll();
      } catch (e) {
        Get.snackbar("Failed!", "Try Again");
        debugPrint("****$e");
      }
    }
    hideLoading();
  }

  void decreaseIndex() {
    if (currentIndex.value > 0) {
      currentIndex.value = currentIndex.value - 1;
      selectedParentId.value = mainCategories[currentIndex.value].name;
    }
    debugPrint("****SelectedCategory: ${selectedParentId.value}");
  }

  void increaseIndex() {
    if (currentIndex.value + 1 < mainCategories.length) {
      currentIndex.value = currentIndex.value + 1;
      selectedParentId.value = mainCategories[currentIndex.value].name;
    }
    debugPrint("****SelectedCategory: ${selectedParentId.value}");
  }

  @override
  void onInit() {
    mainCategories.value = homeController.mainCategories;
    _database.watch(firstCategoriesCollection).listen((event) {
      if (event.docs.isNotEmpty) {
        subCatgories.value =
            event.docs.map((e) => FirstSubCategory.fromJson(e.data())).toList();
      }
    });
    super.onInit();
  }
}
