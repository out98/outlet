import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:outlet/constant/mock.dart';
import 'package:outlet/controller/home_controller.dart';
import 'package:outlet/model/auth_user.dart';
import 'package:outlet/model/review.dart';
import 'package:uuid/uuid.dart';

import '../../../../service/database.dart';

class ProuctDetailController extends GetxController {
  final _database = Database();
  final HomeController _homeController = Get.find();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  RxList<Review> reviewsList = <Review>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var rating = 0.0.obs;
  var rateError = false.obs;
  var reviewError = false.obs;
  var firstTimePressed = false.obs;

  void changeRating(double value) {
    rating.value = value;
    ratingController.text = value.toString();
  }

  Future<void> writeReiew(String productId) async {
    firstTimePressed.value = true;
    if (isLoading.value) {
      return;
    }
    if (checkValidate()) {
      isLoading.value = true;
      final currentUser = AuthUser(
        id: "testuserid",
        emailAddress: "testuser@gmail.com",
        userName: "Test User",
        image: mockProfile,
        points: 0,
      ); /*TO DO TO insert with real 
      authenticated user.*/
      final review = Review(
        id: Uuid().v1(),
        parentId: productId,
        user: currentUser,
        rating: rating.value,
        reviewMessage: reviewController.text,
        dateTime: DateTime.now(),
      );
      try {
        await _database.write(
          collectionPath: reviewCollection,
          documentPath: review.id,
          data: review.toJson(),
        );
        updateRating(productId);
        isLoading.value = false;
        clearAll();
        reviewsList.add(review);
        reviewsList
            .sort((v1, v2) => v1.dateTime.millisecondsSinceEpoch.compareTo(
                  v2.dateTime.millisecondsSinceEpoch,
                ));
        reviewsList.value = reviewsList.reversed.toList();
      } catch (e) {
        Get.snackbar("Failed!", "Try again.");
        isLoading.value = false;
      }
    }
  }

  void clearAll() {
    rating.value = 0.0;
    ratingController.clear();
    reviewController.clear();
  }

  Future<void> updateRating(String productId) async {
    await _database.firestore.runTransaction((transaction) async {
      final secureSnapshot = await transaction.get(
          _database.firestore.collection(productsCollection).doc(productId));
      final double previousRating = secureSnapshot.get("rating");
      transaction.set(
        secureSnapshot.reference,
        {
          "rating": previousRating + rating.value,
        },
        SetOptions(merge: true),
      );
    });
  }

  bool checkValidate() {
    if (validateReview() && validateRating()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateReview() {
    if (reviewController.text.isEmpty) {
      reviewError.value = true;
      return false;
    } else {
      reviewError.value = false;
      return true;
    }
  }

  bool validateRating() {
    if (rating.value < 0 || rating.value == 0) {
      rateError.value = true;
      return false;
    } else {
      rateError.value = false;
      return true;
    }
  }

  @override
  void onInit() async {
    _database
        .readCollectionWhere(
      collectionPath: reviewCollection,
      field: "parentId",
      equalField: _homeController.selectedItem.value?.id,
    )
        .then((value) {
      reviewsList.value = value.docs.map((e) {
        return Review.fromJson(e.data());
      }).toList();
    });
    super.onInit();
  }
}
