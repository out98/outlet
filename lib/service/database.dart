import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/controller/auth_controller.dart';
import 'package:outlet/model/product.dart';
import 'package:uuid/uuid.dart';

import '../constant/collection_path.dart';
import '../model/purchase.dart';
import 'api.dart';

class Database {
  final firestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  //Write PurchaseData
  Future<void> writePurchaseData(PurchaseModel model) async {
    List<Product> rewardProductList =
        model.items.where((element) => element.requirePoint! > 0).toList();
    if (!(model.bankSlipImage == null)) {
      final file = File(model.bankSlipImage!);
      debugPrint("**************${model.bankSlipImage!}");
      try {
        await firebaseStorage
            .ref()
            .child("bankSlip/${Uuid().v1()}")
            .putFile(file)
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final purchaseModel = model.copyWith(bankSlipImage: value).toJson();
            //Then we set this user into Firestore
            await firestore
                .collection(purchaseCollection)
                .doc(model.id)
                .set(purchaseModel)
                .then((value) async {
              //Push Notification
              try {
                Api.sendOrder(
                        "အော်ဒါတင်ခြင်း",
                        "🧑အမည်:${model.name}\n"
                            "🏠လိပ်စာ: ${model.address}\n"
                            "✍အီးမေးလ်: ${model.email}")
                    .then((value) =>
                        debugPrint("*****Success push notification*****"));
              } catch (e) {
                debugPrint("********Push Failed: $e**");
              }
              int totalPay = 0;
              for (var item in model.items) {
                if (item.discountPrice! > 0) {
                  totalPay += item.count! * item.discountPrice!;
                } else if (!(item.requirePoint! > 0)) {
                  totalPay += item.count! * item.price;
                }
              }
              debugPrint("*******Totalpay: $totalPay********");
              await increaseCurrentUserPoint(
                  int.parse("${totalPay / 100}".split('.').first));
              if (rewardProductList.isNotEmpty) {
                int totalPoints = 0;
                for (var item in rewardProductList) {
                  totalPoints += item.requirePoint! * item.count!;
                }
                try {
                  await reduceCurrentUserPoint(totalPoints);
                } catch (e) {
                  debugPrint("*****ReduceFailed: $e");
                }
              }
            });
          });
        });
      } on FirebaseException catch (e) {
        debugPrint("*******Image Upload Error $e******");
      }
    } else {
      try {
        await firestore
            .collection(purchaseCollection)
            .doc(model.id)
            .set(model.toJson())
            .then((value) async {
          //Push Notification
          try {
            Api.sendOrder(
                    "အော်ဒါတင်ခြင်း",
                    "🧑အမည်:${model.name}\n"
                        "🏠လိပ်စာ: ${model.address}\n"
                        "✍အီးမေးလ်: ${model.email}")
                .then((value) =>
                    debugPrint("*****Success push notification*****"));
          } catch (e) {
            debugPrint("********Push Failed: $e**");
          }
          int totalPay = 0;
          for (var item in model.items) {
            if (item.discountPrice! > 0) {
              totalPay += item.count! * item.discountPrice!;
            } else if (!(item.requirePoint! > 0)) {
              totalPay += item.count! * item.price;
            }
          }
          debugPrint("*******Totalpay: $totalPay********");
          await increaseCurrentUserPoint(
              int.parse("${totalPay / 100}".split('.').first));
          if (rewardProductList.isNotEmpty) {
            int totalPoints = 0;
            for (var item in rewardProductList) {
              totalPoints += item.requirePoint! * item.count!;
            }
            try {
              await reduceCurrentUserPoint(totalPoints);
            } catch (e) {
              debugPrint("*****ReduceFailed: $e");
            }
          }
        });
      } on FirebaseException catch (e) {
        debugPrint("*******Image Upload Error $e******");
      }
    }
  }

//--------------Functions For Reward System------------------------------//
  //Give Point Depend on Order Product Count
  Future<void> increaseCurrentUserPoint(int increasePoint) async {
    AuthController _controller = Get.find();
    firestore.runTransaction(
      (transaction) async {
        final secureSnapshot = await transaction.get(firestore
            .collection(userCollection)
            .doc(_controller.currentUser.value!.id));

        final int previousPoint = secureSnapshot.get("points") as int;
        debugPrint(
            "*********Point in increase current user point function:$increasePoint");
        transaction.update(
          secureSnapshot.reference,
          {
            "points": previousPoint + increasePoint,
          },
        );
      },
    );
  }

  //Reduce Point Depend on Order Product Count
  Future<void> reduceCurrentUserPoint(int reducePoint) async {
    AuthController _controller = Get.find();
    firestore.runTransaction(
      (transaction) async {
        final secureSnapshot = await transaction.get(firestore
            .collection(userCollection)
            .doc(_controller.currentUser.value!.id));

        final int previousPoint = secureSnapshot.get("points") as int;

        transaction.update(
          secureSnapshot.reference,
          {
            "points": previousPoint - reducePoint,
          },
        );
      },
    );
  }
  ///////////////////////

  Future<void> write({
    required String collectionPath,
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collectionPath).doc(documentPath).set(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watch(String collectionPath) =>
      firestore.collection(collectionPath).orderBy("dateTime").snapshots();
  Stream<QuerySnapshot<Map<String, dynamic>>> watchSimple(
          String collectionPath) =>
      firestore.collection(collectionPath).snapshots();

  Future<QuerySnapshot<Map<String, dynamic>>> readCollectionWhere({
    required String collectionPath,
    required dynamic field,
    required dynamic equalField,
  }) async {
    return await firestore
        .collection(collectionPath)
        .where(field, isEqualTo: equalField)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readCollection({
    required String collectionPath,
  }) async {
    return await firestore.collection(collectionPath).get();
  }

  Future<void> delete({
    required String collectionPath,
    required String documentPath,
  }) async {
    await firestore.collection(collectionPath).doc(documentPath).delete();
  }
}
