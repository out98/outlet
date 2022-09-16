import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:outlet/model/brand.dart';
import 'package:outlet/model/filter_enum.dart';
import 'package:outlet/model/first_sub_category.dart';
import 'package:outlet/model/main_category.dart';
import 'package:outlet/model/product.dart';
import '../model/advertisement.dart';
import '../model/purchase.dart';
import '../service/database.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final database = Database();
  Rxn<Brand?> editBrand = Rxn<Brand>(null);
  String selectedCategoryId = "";
  RxString filterMainId = "".obs;
  RxString filterBrandId = "".obs;
  Rxn<Product?> selectedItem = Rxn<Product?>(null);
  Rxn<FilterEnum> filterEnum = Rxn<FilterEnum>(filter[0].fEnum);
  set setFilterMainId(String value) => filterMainId.value = value;
  set setFilterBrandId(String value) => filterBrandId.value = value;
  set setFilterEnum(FilterEnum value) => filterEnum.value = value;
  set setSelectedItem(Product value) => selectedItem.value = value;
  set setEditBrand(Brand brand) => editBrand.value = brand;
  set setSelectedCategoryId(String value) => selectedCategoryId = value;

  final RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  final RxList<Product> products = <Product>[].obs;
  final RxList<Brand> brands = <Brand>[].obs;
  final RxList<Advertisement> advertisement = <Advertisement>[].obs;

  final RxList<FirstSubCategory> firstCategories = <FirstSubCategory>[].obs;
  List<FirstSubCategory> selectedFirstCategories = <FirstSubCategory>[];
  RxList<Product> selectedProducts = <Product>[].obs;
  Rxn<Product?> editProduct = Rxn<Product?>(null);
  final RxList<PurchaseModel> _purchcases = <PurchaseModel>[].obs; ////

  set setEditProduct(Product? value) => editProduct.value = value;

  List<PurchaseModel> purchcasesCashOn() {
    return _purchcases.where((item) => item.bankSlipImage == null).toList();
  }

  List<PurchaseModel> purchcasesPrePay() {
    return _purchcases.where((item) => item.bankSlipImage != null).toList();
  }

  void findSelectedProducts(String parentId) {
    selectedProducts.value =
        products.where((e) => e.parentId == parentId).toList();
  }

  void findFirstCategories(String parentId) {
    debugPrint("******FirstCategoiresLength: ${firstCategories.length}");
    selectedFirstCategories =
        firstCategories.where((e) => e.parentId == parentId).toList();
    if (selectedFirstCategories.isNotEmpty) {
      filterMainId.value = selectedFirstCategories.first.id;
    } else {
      filterMainId.value = parentId;
    }
  }

  void filterFunction() {
    var filterResult = products
        .where((e) =>
            e.parentId == filterMainId.value &&
            e.brandId == filterBrandId.value)
        .toList();
    if (filterResult.isNotEmpty) {
      switch (filterEnum.value) {
        case FilterEnum.newestFirst:
          filterResult.sort((v1, v2) => v1.dateTime.millisecondsSinceEpoch
              .compareTo(v2.dateTime.millisecondsSinceEpoch));
          selectedProducts.value = filterResult.reversed.toList();
          break;
        case FilterEnum.oldestFirst:
          filterResult.sort((v1, v2) => v1.dateTime.millisecondsSinceEpoch
              .compareTo(v2.dateTime.millisecondsSinceEpoch));
          selectedProducts.value = filterResult;
          break;
        case FilterEnum.expensive:
          filterResult.sort((v1, v2) => v1.price.compareTo(v2.price));
          selectedProducts.value = filterResult.reversed.toList();
          break;
        case FilterEnum.cheapest:
          filterResult.sort((v1, v2) => v1.price.compareTo(v2.price));
          selectedProducts.value = filterResult;
          break;
        case FilterEnum.letterAscending:
          filterResult.sort((v1, v2) =>
              v1.name.toUpperCase().compareTo(v2.name.toUpperCase()));
          selectedProducts.value = filterResult;
          break;
        case FilterEnum.letterDescending:
          filterResult.sort((v1, v2) =>
              v1.name.toUpperCase().compareTo(v2.name.toUpperCase()));
          selectedProducts.value = filterResult.reversed.toList();
          break;
        case FilterEnum.ratingHightToLow:
          filterResult.sort((v1, v2) => v1.rating!.compareTo(v2.rating!));
          selectedProducts.value = filterResult.reversed.toList();
          break;
        case FilterEnum.ratingLowToHight:
          filterResult.sort((v1, v2) => v1.rating!.compareTo(v2.rating!));
          selectedProducts.value = filterResult;
          break;
        default:
      }
    } else {
      selectedProducts.value = [];
    }
  }

  late ByteData oleoBold;
  late ByteData cherryUnicode;
  @override
  void onInit() async {
    oleoBold = await rootBundle.load("fonts/OleoScriptSwashCaps-Bold.ttf");
    cherryUnicode = await rootBundle.load("fonts/Cherry_Unicode.ttf");
    database.watch(advertisementCollection).listen((event) {
      advertisement.value =
          event.docs.map((e) => Advertisement.fromJson(e.data())).toList();
    });
    database.watch(mainCategoriesCollection).listen((event) {
      mainCategories.value =
          event.docs.map((e) => MainCategory.fromJson(e.data())).toList();
    });
    database.watch(firstCategoriesCollection).listen((event) {
      firstCategories.value =
          event.docs.map((e) => FirstSubCategory.fromJson(e.data())).toList();
    });
    database.watch(productsCollection).listen((event) {
      products.value =
          event.docs.map((e) => Product.fromJson(e.data())).toList();
    });
    database.watchSimple(brandsCollection).listen((event) {
      if (event.docs.isNotEmpty) {
        brands.value = event.docs.map((e) => Brand.fromJson(e.data())).toList();
        debugPrint("*****Brand Length: ${brands.length}");
        filterBrandId.value = brands.first.id;
      }
    });
    database.watch(purchaseCollection).listen((event) {
      if (event.docs.isEmpty) {
        _purchcases.clear();
      } else {
        _purchcases.value =
            event.docs.map((e) => PurchaseModel.fromJson(e.data())).toList();
      }
    });
    super.onInit();
  }
}
