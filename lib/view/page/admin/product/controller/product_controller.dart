import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:outlet/model/first_sub_category.dart';
import 'package:outlet/model/product.dart';
import 'package:uuid/uuid.dart';

import '../../../../../controller/home_controller.dart';
import '../../../../../model/brand.dart';
import '../../../../../service/database.dart';
import '../../../../widget/show_loading/show_loading.dart';

enum ProductStatusType {
  none,
  nEW,
  recommend,
}

class ProductController extends GetxController {
  final _database = Database();
  final HomeController _homeController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> searchItems = <Product>[].obs;
  RxList<String> removeImageList = <String>[].obs;
  final RxList<Brand> brands = <Brand>[].obs;
  final RxList<FirstSubCategory> subCategories = <FirstSubCategory>[].obs;
  final TextEditingController editingController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController featuresController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  final TextEditingController requirePointController = TextEditingController();

  var isSearch = false.obs;
  var isFile = false.obs;
  RxList<String> pickedImage = <String>[].obs;
  var selectedBrandName = "".obs;
  var selectedSubCategoryName = "".obs;
  var statusType = "".obs;
  //UpDownWidget
  var categoryIndex = 0.obs;
  var brandIndex = 0.obs;
  //
  /* Rxn<ProductStatusType> statusType =
      Rxn<ProductStatusType>(ProductStatusType.none); */

  void setStatusType(String value) => statusType.value = value;

  void decreaseCategory() {
    if (categoryIndex.value > 0) {
      categoryIndex.value = categoryIndex.value - 1;
      selectedSubCategoryName.value = subCategories[categoryIndex.value].name;
    }
    debugPrint("****SelectedCategory: ${selectedSubCategoryName.value}");
  }

  void increaseCategory() {
    if (categoryIndex.value + 1 < subCategories.length) {
      categoryIndex.value = categoryIndex.value + 1;
      selectedSubCategoryName.value = subCategories[categoryIndex.value].name;
    }
    debugPrint("****SelectedCategory: ${selectedSubCategoryName.value}");
  }

  void decreaseBrand() {
    if (brandIndex.value > 0) {
      brandIndex.value = brandIndex.value - 1;
      selectedBrandName.value = brands[brandIndex.value].name;
    }
    debugPrint("****SelectedCategory: ${selectedBrandName.value}");
  }

  void increaseBrand() {
    if (brandIndex.value + 1 < brands.length) {
      brandIndex.value = brandIndex.value + 1;
      selectedBrandName.value = brands[brandIndex.value].name;
    }
    debugPrint("****SelectedCategory: ${selectedBrandName.value}");
  }

  String? validate(String? value, String label) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "$label is required";
    }
  }

  void deleteImage(String path) {
    pickedImage.remove(path);
    removeImageList.add(path);
  }

  void onSearch(String name) {
    isSearch.value = true;
    searchItems.value = products
        .where((p0) => p0.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  void configureForEditProduct(Product product) {
    nameController.text = product.name;
    descriptionController.text = product.description;
    featuresController.text = product.features ?? "";
    priceController.text = product.price.toString();
    discountController.text = (product.discountPrice ?? 0).toString();
    requirePointController.text = (product.requirePoint ?? 0).toString();

    pickedImage.value = product.image;
    selectedBrandName.value =
        brands.where((p0) => p0.id == product.brandId).first.name;
    selectedSubCategoryName.value =
        subCategories.where((p0) => p0.id == product.parentId).first.name;
    statusType.value = product.status ?? "";
  }

  void clearAll() {
    nameController.clear();
    descriptionController.clear();
    featuresController.clear();
    priceController.clear();
    discountController.clear();
    requirePointController.clear();
    pickedImage.value = [];
    isFile.value = false;
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: productsCollection,
      documentPath: id,
    );
  }

  bool checkSelectType() {
    if (pickedImage.isEmpty ||
        selectedBrandName.isEmpty ||
        selectedSubCategoryName.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void clearSearch() {
    editingController.clear();
    isSearch.value = false;
  }

  Future<List<String>> uploadMultipleImages(
      List<File> images, String productId) async {
    final List<String> resultImages = [];
    for (var element in images) {
      await FirebaseStorage.instance
          .ref()
          .child("products/$productId/${Uuid().v1()}")
          .putFile(element)
          .then((snapshot) async {
        await snapshot.ref
            .getDownloadURL()
            .then((value) => resultImages.add(value));
      });
    }
    return resultImages;
  }

  Future<void> edit() async {
    final element = _homeController.editProduct.value!;
    if (formKey.currentState?.validate() == true && checkSelectType()) {
      showLoading();
      try {
        if (isFile.value) {
          final images = pickedImage.map<File>((e) => File(e)).toList();
          await uploadMultipleImages(images, element.id).then((value) async {
            final product = Product(
              id: element.id,
              name: nameController.text,
              image: value,
              discountPrice: int.parse(discountController.text),
              requirePoint: int.parse(requirePointController.text),
              rating: _homeController.editProduct.value?.rating ?? 0.0,
              description: descriptionController.text,
              features: featuresController.text,
              price: int.parse(priceController.text),
              status: statusType.value,
              parentId: subCategories
                  .where((e) => e.name == selectedSubCategoryName.value)
                  .first
                  .id,
              brandId: brands
                  .where((e) => e.name == selectedBrandName.value)
                  .first
                  .id,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: productsCollection,
              documentPath: product.id,
              data: product.toJson(),
            );
          });
          hideLoading();
          Get.back();
        } else {
          final product = Product(
            id: element.id,
            name: nameController.text,
            image: pickedImage,
            discountPrice: int.parse(discountController.text),
            requirePoint: int.parse(requirePointController.text),
            rating: _homeController.editProduct.value?.rating ?? 0.0,
            description: descriptionController.text,
            features: featuresController.text,
            price: int.parse(priceController.text),
            status: statusType.value,
            parentId: subCategories
                .where((e) => e.name == selectedSubCategoryName.value)
                .first
                .id,
            brandId:
                brands.where((e) => e.name == selectedBrandName.value).first.id,
            dateTime: DateTime.now(),
          );
          await _database.write(
            collectionPath: productsCollection,
            documentPath: product.id,
            data: product.toJson(),
          );
          hideLoading();
          Get.back();
        }
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Try again.");
      }
    }
  }

  Future<void> save() async {
    showLoading();
    if (formKey.currentState?.validate() == true && checkSelectType()) {
      try {
        final id = Uuid().v1();
        final images = pickedImage.map<File>((e) => File(e)).toList();
        await uploadMultipleImages(images, id).then((value) async {
          final product = Product(
            id: id,
            name: nameController.text,
            image: value,
            rating: 0,
            description: descriptionController.text,
            features: featuresController.text,
            price: int.parse(priceController.text),
            discountPrice: int.parse(discountController.text),
            requirePoint: int.parse(requirePointController.text),
            status: statusType.value,
            parentId: subCategories
                .where((e) => e.name == selectedSubCategoryName.value)
                .first
                .id,
            brandId:
                brands.where((e) => e.name == selectedBrandName.value).first.id,
            dateTime: DateTime.now(),
          );
          await _database.write(
            collectionPath: productsCollection,
            documentPath: product.id,
            data: product.toJson(),
          );
          clearAll();
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
      final List<XFile>? images = await ImagePicker().pickMultiImage();
      if (!(images == null) && images.isNotEmpty) {
        pickedImage.value = images.map((e) => e.path).toList();
        isFile.value = true;
      }
    } catch (e) {
      isFile.value = false;
      debugPrint("Error Bank Slip Image Picking");
    }
  }

  @override
  void onInit() {
    products.value = _homeController.products;
    brands.value = _homeController.brands;
    subCategories.value = _homeController.firstCategories;
    super.onInit();
  }
}
