import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet/constant/collection_path.dart';
import 'package:outlet/constant/mock.dart';
import 'package:outlet/model/auth_user.dart';
import 'package:outlet/service/auth.dart';

import '../service/database.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _authObject = Auth();
  final _database = Database();
  StreamSubscription? userStreamSubscription;
  int currentUserPoint = 0;
  Rxn<AuthUser> currentUser = Rxn<AuthUser>(AuthUser.guest());
  @override
  void onInit() {
    listenCurrentUser();
    super.onInit();
  }

  Future<void> googleSingIn() async {
    await _authObject.signInWithGoogle();
  }

  Future<void> logOut() async {
    _authObject.logOut().then((value) {
      currentUser.value = AuthUser.guest();
      currentUserPoint = 0;
    });
  }

  Future<void> delete() async {
    _authObject.deleteAccount(currentUser.value!.id).then((value) {
      currentUser.value = AuthUser.guest();
      currentUserPoint = 0;
    });
  }

  void listenCurrentUser() {
    _auth.authStateChanges().listen((user) async {
      if (user == null && user?.photoURL == null) {
        //Nothing do if user is null & annonymous user
      } else {
        if (!(user == null)) {
          debugPrint("*******user is not null****");
          //we need to check document reference is already defined
          final snapshot = await FirebaseFirestore.instance
              .collection(userCollection)
              .doc(user.uid)
              .get();
          if (!snapshot.exists) {
            //If not define before
            debugPrint("******Document is not exist so,we write to firebase");
            currentUser.value = AuthUser(
              id: user.uid,
              emailAddress: user.email!,
              userName: user.displayName!,
              image: user.photoURL!,
              points: 0,
              status: 1,
            );
            await _database.write(
              collectionPath: userCollection,
              documentPath: currentUser.value!.id,
              data: currentUser.value!.toJson(),
            );
            if (!(userStreamSubscription == null)) {
              //if already subscripe before,need to cancel
              //to subscripe new
              userStreamSubscription?.cancel();
            }
            //If user is not null,we watch this current user's document
            userStreamSubscription = FirebaseFirestore.instance
                .collection(userCollection)
                .doc(user.uid)
                .snapshots()
                .listen((event) {
              if (event.exists) {
                debugPrint("****UserEvent: ${event.data()}");
                currentUser.value = AuthUser.fromJson(event.data()!);
                currentUserPoint = currentUser.value!.points;
              }
            });
          } else {
            currentUser.value = AuthUser.fromJson(snapshot.data()!);
            currentUserPoint = currentUser.value!.points;
          }
        }
      }
    });
  }
}
