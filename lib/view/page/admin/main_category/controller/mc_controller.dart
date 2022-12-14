import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:uuid/uuid.dart';

import '../../../../../model/main_category.dart';
import '../../../../../service/database.dart';
import '../../../../widget/show_loading/show_loading.dart';

class MCController extends GetxController {
  final _database = Database();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  final TextEditingController nameController = TextEditingController();
  var pickedImage = "".obs;

  String? validate(String? value) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "Name is required";
    }
  }

  void clearAll() {
    nameController.clear();
    pickedImage.value = "";
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: mainCategoriesCollection,
      documentPath: id,
    );
  }

  Future<void> save() async {
    showLoading();
    if (formKey.currentState?.validate() == true && pickedImage.isNotEmpty) {
      try {
        await FirebaseStorage.instance
            .ref()
            .child("mainCategories/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final ad = MainCategory(
              id: Uuid().v1(),
              image: value,
              name: nameController.text,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: mainCategoriesCollection,
              documentPath: ad.id,
              data: ad.toJson(),
            );
            clearAll();
          });
        });
      } catch (e) {
        Get.snackbar("Failed!", "Try Again");
        debugPrint("****$e");
      }
    }
    hideLoading();
  }

  pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage.value = image?.path ?? "";
    } catch (e) {
      debugPrint("Error Bank Slip Image Picking");
    }
  }

  @override
  void onInit() {
    _database.watch(mainCategoriesCollection).listen((event) {
      if (event.docs.isNotEmpty) {
        mainCategories.value =
            event.docs.map((e) => MainCategory.fromJson(e.data())).toList();
      }
    });
    super.onInit();
  }
}
