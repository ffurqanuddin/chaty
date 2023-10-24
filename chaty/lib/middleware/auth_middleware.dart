import 'dart:developer';

import 'package:chaty/apis/auth_api.dart';
import 'package:chaty/apis/firestore_api.dart';
import 'package:chaty/feature/auth/ui/auth_page.dart';
import 'package:chaty/feature/home/ui/home_page.dart';
import 'package:chaty/helper/helper.dart';
import 'package:flutter/material.dart';

class AuthMiddleWare {
  ///Instance of AuthAPI Class
  AuthAPI authAPI = AuthAPI();

  ///Instance of FirestoreAPI Class
  FirestoreAPI firestoreAPI = FirestoreAPI();

  ///Continue With Google
  signInWithGoogle(BuildContext context) async{
    ///Show Loading DialogBox
    Helper.showLoadingDialogBox(context);

    ///------Sign In With Google-----///
   await authAPI.signInWithGoogle();

    try {
      ///---Check if user Exist in firestore database---//
      if (await firestoreAPI.userExists()) {
        ///Close Loading DialogBox
        Navigator.pop(context);

        ///---> Goto to HomePage
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => true);
      }

      ///If user not exists then create new user in firestore database
      else {
        ///Store User Data in firestore database
       await firestoreAPI.createUser();

        ///Close Loading DialogBox
        Navigator.pop(context);

        ///---> Goto to HomePage
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => true);
      }
    }

    ///Catch Error if something went wrong
    catch (error) {
      log("----(****Auth Middleware Class****)------ signInWithGoogle Function() ::::::::: Error \n  $error ");
    }
  }

  ///Google Sign Out
  Future logOutNow(BuildContext context) async {
    await authAPI.signOutGoogle().then((value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ),
        (route) => true));
  }
}
