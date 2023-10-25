import 'dart:developer';
import 'dart:io';

import 'package:chaty/apis/firestore_api.dart';
import 'package:chaty/helper/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../feature/customization/data/customization_data.dart';
import '../models/chat_user_model.dart';

class FirestoreMiddleWare {
  FirestoreAPI firestoreAPI = FirestoreAPI();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserData() {
    return firestoreAPI.getAllUserData();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserData() {
    return firestoreAPI.getCurrentUserData();
  }

  Future changeCustomizationSetting(
      {required WidgetRef ref, required BuildContext context}) async {
    Helper.showLoadingDialogBox(context);

    await FirestoreAPI()
        .changeCustomization(
      themeValue: ref.watch(themeValueStateProvider.notifier).state,
      tickColor: ref
                  .watch(currentVerificationTickStateProvider.notifier)
                  .state ==
              VerificationTickValue.defaultTick
          ? "4472C4"
          : ref.watch(currentVerificationTickStateProvider.notifier).state ==
                  VerificationTickValue.amber
              ? "FFB302"
              : ref
                          .watch(currentVerificationTickStateProvider.notifier)
                          .state ==
                      VerificationTickValue.pink
                  ? "AA336A"
                  : ref
                              .watch(
                                  currentVerificationTickStateProvider.notifier)
                              .state ==
                          VerificationTickValue.green
                      ? "50C878"
                      : "FF0000",
    )
        .then((value) {
      ///Close Loading Dialog Box
      Navigator.pop(context);

      ///Then goto Home Screen
      Navigator.pop(context);
    });
  }

  /////------------EXTRA--------------/////////
  // ///get self info
  // Future<void> getSelfInfo() async {
  //   try {
  //     await firestoreAPI.getSelfInfo();
  //   } catch (error) {
  //     log("********Firestore Middleware ******** getselfinfo  : error \n");
  //   }
  // }
  //
  // ChatUserModel getSelfChatModel() {
  //   return firestoreAPI.me;
  // }
////-------------------------------------///

  ///Update Current User Username
  Future updateCurrentUserUsername({
    username,
  }) async {
    await firestoreAPI.firestore
        .collection(firestoreAPI.userCollection)
        .doc(firestoreAPI.currentUserID)
        .update({
      "name": username,
    });
  }


  ///Update Current User About
  Future updateCurrentUserAbout({
    about,
  }) async {
    await firestoreAPI.firestore
        .collection(firestoreAPI.userCollection)
        .doc(firestoreAPI.currentUserID)
        .update({
      "about": about,
    });
  }


  ///Update Current User Image
  Future updateCurrentUserImage({
    image,
  }) async {
    await firestoreAPI.firestore
        .collection(firestoreAPI.userCollection)
        .doc(firestoreAPI.currentUserID)
        .update({
      "image": image,
    });
  }
}
