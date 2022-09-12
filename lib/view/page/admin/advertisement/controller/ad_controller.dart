import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:outlet/model/advertisement.dart';
import 'package:outlet/view/widget/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../../../../../service/database.dart';

class ADController extends GetxController {
  final _database = Database();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<Advertisement> advertisement = <Advertisement>[].obs;
  final TextEditingController nameController = TextEditingController();
  var pickedImage = "".obs;
  var isHot = false.obs;
  var isLoading = false.obs;

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
    isHot.value = false;
  }

  Future<void> save() async {
    showLoading();
    if (isLoading.value) {
      return;
    }
    if (formKey.currentState?.validate() == true && pickedImage.isNotEmpty) {
      isLoading.value = true;
      try {
        await FirebaseStorage.instance
            .ref()
            .child("profileImages/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final ad = Advertisement(
              id: Uuid().v1(),
              image: value,
              name: nameController.text,
              isHot: isHot.value,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: advertisementCollection,
              documentPath: ad.id,
              data: ad.toJson(),
            );
            isLoading.value = false;
            clearAll();
          });
        });
      } catch (e) {
        Get.snackbar("Failed!", "Try Again");
        debugPrint("****$e");
        isLoading.value = false;
      }
    }
    hideLoading();
  }

  changeIsHot(bool value) => isHot.value = value;

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
    _database.watch(advertisementCollection).listen((event) {
      if (event.docs.isNotEmpty) {
        advertisement.value =
            event.docs.map((e) => Advertisement.fromJson(e.data())).toList();
      }
    });
    super.onInit();
  }
}
