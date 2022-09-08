import 'package:get/get.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:outlet/model/first_sub_category.dart';
import 'package:outlet/model/main_category.dart';
import '../service/database.dart';

class HomeController extends GetxController{
  final database = Database();
  String selectedCategoryId = "";
  set setSelectedCategoryId(String value) => selectedCategoryId = value; 

  final RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  final RxList<FirstSubCategory> firstCategories = <FirstSubCategory>[].obs;

  @override
  void onInit() {
    database.watch(mainCategoriesCollection)
    .listen((event) {
      mainCategories.value = event.docs.map((e) => MainCategory.fromJson(e.data())).toList();
    });
    database.watch(firstCategoriesCollection)
    .listen((event) {
      firstCategories.value = event.docs.map((e) 
      => FirstSubCategory.fromJson(e.data())).toList();
    });
    super.onInit();
  }
//**.....................Mock Data Inserting................. */
 /*  Future<void> addMainCategories() async{
    final mainCategory = mainCategories;
    for (var element in mainCategory) {
      await database.write(
      collectionPath: mainCategoriesCollection, 
      documentPath: element.id, 
      data: element.toJson(),
      );
    }
  }

  Future<void> addFirstCategorysOfFood() async{
    final parentId = mainCategories.where((element) => element.name == "food")
    .first.id;
    for (var i = 0; i < firstCategoryOfFoods.length; i++) {
      final data = FirstSubCategory(
        id: Uuid().v1(), 
        name: firstCategoryOfFoods[i], 
        parentId: parentId, 
        dateTime: DateTime.now(),
        );
        await database.write(
        collectionPath: firstCategoriesCollection, 
        documentPath: data.id, 
        data: data.toJson(),
        );
    }
  }

  Future<void> addFirstCategorysOfFashions() async{
    final parentId = mainCategories.where((element) => element.name == "fashion")
    .first.id;
    for (var i = 0; i < firstCategoryOfFashions.length; i++) {
      final data = FirstSubCategory(
        id: Uuid().v1(), 
        name: firstCategoryOfFashions[i], 
        parentId: parentId, 
        dateTime: DateTime.now(),
        );
        await database.write(
        collectionPath: firstCategoriesCollection, 
        documentPath: data.id, 
        data: data.toJson(),
        );
    }
  }
  Future<void> addFirstCategorysOfDailyGoods() async{
    final parentId = mainCategories.where((element) => element.name == "daily goods")
    .first.id;
    for (var i = 0; i < firstCategoryOfDailyGoods.length; i++) {
      final data = FirstSubCategory(
        id: Uuid().v1(), 
        name: firstCategoryOfDailyGoods[i], 
        parentId: parentId, 
        dateTime: DateTime.now(),
        );
        await database.write(
        collectionPath: firstCategoriesCollection, 
        documentPath: data.id, 
        data: data.toJson(),
        );
    }
  }
  Future<void> addFirstCategorysOfInterior() async{
    final parentId = mainCategories.where((element) => element.name == "interior·kitchen supplies")
    .first.id;
    for (var i = 0; i < firstCategoryOfInterior.length; i++) {
      final data = FirstSubCategory(
        id: Uuid().v1(), 
        name: firstCategoryOfInterior[i], 
        parentId: parentId, 
        dateTime: DateTime.now(),
        );
        await database.write(
        collectionPath: firstCategoriesCollection, 
        documentPath: data.id, 
        data: data.toJson(),
        );
    }
  } */
}