import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/model/brand.dart';
import 'package:outlet/view/widget/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../../../../../service/database.dart';

class BrandController extends GetxController {
  final _database = Database();
  final HomeController _homeController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<Brand> brands = <Brand>[].obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subNameController = TextEditingController();

  final TextEditingController statusController = TextEditingController();

  var pickedImage = "".obs;

  String? validate(String? value, String label) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "$label is required";
    }
  }

  void clearAll() {
    nameController.clear();
    subNameController.clear();
    statusController.clear();
    pickedImage.value = "";
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: brandsCollection,
      documentPath: id,
    );
  }

  Future<void> save() async {
    showLoading();
    if (formKey.currentState?.validate() == true && pickedImage.isNotEmpty) {
      try {
        await FirebaseStorage.instance
            .ref()
            .child("brands/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final ad = Brand(
              id: Uuid().v1(),
              image: value,
              name: nameController.text,
              subName: subNameController.text,
              status: statusController.text,
            );
            await _database.write(
              collectionPath: brandsCollection,
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
    brands.value = _homeController.brands;
    super.onInit();
  }
}
