import 'dart:developer';

import 'package:chaty/apis/auth_api.dart';
import 'package:chaty/models/chat_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreAPI {
  ///AuthAPI Instance
  AuthAPI authAPI = AuthAPI();

  ///Firestore Instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ///Current user ID
  final currentUserID = AuthAPI().currentUser?.uid;

  ///Current user Display Name
  final currentUserName = AuthAPI().currentUser?.displayName.toString();

  ///Current user Display Image
  final currentUserImage = AuthAPI().currentUser?.photoURL.toString();

  ///Current user Email
  final currentUserEmail = AuthAPI().currentUser?.email.toString();

  ///User Collection Name
  final String userCollection = "users";

  ///For checking user existence
  Future userExists() async {
    return (await firestore.collection(userCollection).doc(currentUserID).get())
        .exists;
  }

  ///Create new user
  Future createUser() async {
    ///Time of creating New User
    final time = DateTime.now().millisecondsSinceEpoch.toString();


      ///ChatUser Model Object
      final chatUser = ChatUserModel(
        image: currentUserImage!,
        about: "Hey, I'm using Chaty Chat",
        name: currentUserName!,
        createdAt: time,
        isOnline: false,
        id: currentUserID!,
        lastActive: time,
        email: currentUserEmail!,
        pushToken: " ",
        blueTick: false,
        blueTickColor: "4472C4",
        themeValue: 0,
      );


    ///Storing ChatUserModel Object to firestore users Collection
    return await firestore
        .collection(userCollection)
        .doc(currentUserID)
        .set(chatUser.toJson());
  }

  ///getAllUsersData
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data =
        firestore.collection(userCollection).where("id", isNotEqualTo: currentUserID).snapshots();
    return data;
  }



  ///getCurrentUsersData
  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserData() {
    final Stream<DocumentSnapshot<Map<String, dynamic>>> data =
    firestore.collection(userCollection).doc(currentUserID).snapshots();
    return data;
  }


  ///Change Customization
  Future changeCustomization({required int themeValue, required String tickColor,})async{
    try {
      await firestore.collection(userCollection).doc(currentUserID).update(
          {


            "theme_value": themeValue,
            "blue_tick_color": tickColor,
          }
      );
    }catch (error){
      log("******changeCustomization Error in firestore_api******\n"+error.toString());
    }
    }

}
