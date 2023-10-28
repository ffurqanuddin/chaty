// Import necessary libraries and modules
import 'package:chaty/feature/home/widgets/home_screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../helper/helper.dart';
import '../../../middleware/firestore_middleware.dart';
import '../../../middleware/picked_image_storage_middleware.dart';

// Define a class for the 'Save Changes' button
class SaveChangesButton extends ConsumerWidget {
  SaveChangesButton({
    super.key, // An optional key for identifying the widget
    required this.usernameController, // Text controller for the username input
    required this.aboutController, // Text controller for the about input
    required this.pickedImagePath, // Path to the picked image
  });

  final TextEditingController usernameController; // Stores the username input
  final TextEditingController aboutController; // Stores the about input
  String pickedImagePath; // Stores the path of the picked image

  // Build the widget that represents the 'Save Changes' button
  @override
  Widget build(BuildContext context, ref) {
    return ElevatedButton(
      onPressed: () {
        // Show a loading dialog box while performing updates

        // Check if the username input is not empty or only spaces
        if (usernameController.text.isNotEmpty &&
            usernameController.text != "" &&
            usernameController.text != " ") {
          // Update the current user's username in Firestore
          FirestoreMiddleWare().updateCurrentUserUsername(username: usernameController.text);
        }

        // Check if the about input is not empty or only spaces
        if (aboutController.text.isNotEmpty &&
            aboutController.text != "" &&
            aboutController.text != " ") {
          // Update the current user's 'about' information in Firestore
          FirestoreMiddleWare().updateCurrentUserAbout(about: aboutController.text);
        }

        // Check if a new image has been picked
        if (pickedImagePath != "") {
          // Upload the picked image to Firebase Storage and Firestore
          FirebaseStorageFirebaseFirestoreMiddleware().uploadImageToFirestore(context, imagePath: pickedImagePath);
        }

        // Close the loading dialog box
        Navigator.pop(context);
        // Return to the 'Home' screen by popping the current screen off the navigation stack
        Navigator.pop(context);
        // Return to the 'Home' screen again to ensure we go back to the correct destination
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(85.w, 6.5.h), // Set button size using responsive sizing
      ),
      child: const Text(
        "Save Changes", // Button label
        style: TextStyle(fontWeight: FontWeight.bold), // Button text style
      ),
    );
  }
}
