import 'dart:developer'; // Import the 'developer' library for logging
import 'dart:io'; // Import the 'io' library for file operations

import 'package:chaty/apis/firestore_api.dart'; // Import FirestoreAPI for user ID
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage SDK

class FirebaseStorageAPI {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance; // Create an instance of Firebase Storage

  // Function to upload an image to Firebase Storage and get its download URL
  Future<String> uploadImageAndGetDownloadURL(String imagePath) async {
    try {


      // final extension = imagePath.path.split(".").last;
      // Create a reference to the Firebase Storage path for the user's profile image
      Reference storageReference = FirebaseStorage.instance.ref().child("profile_images/${FirestoreAPI().currentUserID}.jpg");

      // Delete any existing image from Firebase Storage at the same path
      await storageReference.delete();

      // Upload the new image to Firebase Storage using the 'putFile()' method
      TaskSnapshot uploadTask = await storageReference.putFile(File(imagePath));

      // Get the download URL of the uploaded image
      String downloadURL = await uploadTask.ref.getDownloadURL();

      // Return the download URL
      return downloadURL;
    } catch (error) {
      // If an error occurs during the upload process, log the error and throw an exception
      log("FirebaseStorage API class error \n $error");
      throw Exception(error);
    }
  }
}
