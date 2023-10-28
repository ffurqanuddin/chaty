import 'dart:developer'; // Import the 'developer' library for logging

import 'package:chaty/apis/firebase_storage.dart'; // Import FirebaseStorageAPI for image uploading
import 'package:chaty/apis/firestore_api.dart'; // Import FirestoreAPI for Firestore interactions
import 'package:chaty/helper/helper.dart'; // Import a helper class for UI-related functions
import 'package:flutter/material.dart'; // Import Flutter's material library for UI components

class FirebaseStorageFirebaseFirestoreMiddleware {
  // Function to upload an image to Firebase Storage and update Firestore
  uploadImageToFirestore(context, {required String imagePath}) async {
    Helper.showLoadingDialogBox(context); // Show a loading dialog while processing

    try {
      // Upload the image to Firebase Storage and get the download URL
      final downloadLink = await FirebaseStorageAPI().uploadImageAndGetDownloadURL(imagePath);

      if (downloadLink.isNotEmpty) {
        // Update Firestore with the download URL
        await FirestoreAPI().updateProfileImage(image: downloadLink);

        Navigator.pop(context); // Close the loading dialog

        // Show a success message using a snackbar
        Helper.showSnackbar(msg: "Image updated successfully", bgColor: Colors.green);
      } else {
        Navigator.pop(context); // Close the loading dialog if downloadLink is empty
      }
    } catch (error) {
      // If an error occurs during the process, log the error
      log("***FirebaseStorageFirebaseFirestoreMiddleware Class  \nError: $error");
    }
  }
}
