import 'package:chaty/helper/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthAPI {
  ///FirebaseAuth Instance
    FirebaseAuth auth = FirebaseAuth.instance;


    ///Current User-ID
    User? currentUser = FirebaseAuth.instance.currentUser;

  ///Sign In With Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the user canceled the sign-in process
      if (googleUser == null) {
        // You can return an appropriate error or handle it as needed
        throw Exception('Google Sign-In was canceled');
      }

      // Obtain the authentication details from the Google Sign-In request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using GoogleAuthProvider
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase Authentication using the obtained credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Once signed in, return the UserCredential
      return userCredential;
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(
            "********signInWithGoogle (AuthAPI Class) FirebaseAuthException Error**********: ${error.message} ");
      }

      ///Show Snackbar on Error
      Helper.showSnackbar(msg: error.message.toString(), bgColor: Colors.red);

      // You may want to re-throw the error or handle it differently based on your app's needs
      rethrow;
    }
  }

  ///Google Sign out
  Future<void> signOutGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      // Sign out from Google Sign-In
      await googleSignIn.signOut();

      // Sign out from Firebase Authentication
      await auth.signOut();
    } catch (error) {
      if (kDebugMode) {
        print("********signOutGoogle Error**********: $error ");
      }
      // You may want to re-throw the error or handle it differently based on your app's needs
      rethrow;
    }
  }
}
