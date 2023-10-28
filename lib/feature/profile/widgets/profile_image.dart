import 'dart:io'; // Import the 'io' library for file operations

import 'package:extended_image/extended_image.dart'; // Import an extended image widget
import 'package:flutter/material.dart'; // Import Flutter's material library for UI components
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Flutter Riverpod for state management
import 'package:image_picker/image_picker.dart'; // Import the image picker package for selecting images
import 'package:responsive_sizer/responsive_sizer.dart'; // Import responsive sizing for different screens

import '../../home/widgets/home_screen_app_bar.dart'; // Import the app bar used in the home screen
import '../ui/profile_page.dart'; // Import the profile page for user profiles

class ProfileImageWidget extends ConsumerWidget {
  ProfileImageWidget({super.key,  }); // Constructor for the profile image widget

  @override
  Widget build(BuildContext context, ref) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Avatar
          CircleAvatar(
            radius: 25.w, // Set the radius of the circular avatar
            backgroundImage: (ref.watch(pickedProfileImagePathStateProvider) != "") ? FileImage(File(ref.watch(pickedProfileImagePathStateProvider),), ) : null,
            child: (ref.watch(pickedProfileImagePathStateProvider) == "")
                ?
            ref.watch(getCurrentUsersDataStreamProvider).when(data: (data) {
              final String userImage = data["image"];
              return ExtendedImage.network(
                  width: 49.w,
                  height: 49.w,
                  shape: BoxShape.circle,
                  userImage,
                  borderRadius: BorderRadius.circular(25.w),
                  fit: BoxFit.cover); // Display the user's profile image
            }, error: (error, stackTrace) => const Text(""), loading:  () => const CircularProgressIndicator()) : null,
          ),

          ///----------Edit Button------///
          Positioned(
            bottom: 3.w,
            right: 3.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery); // Pick an image from the gallery
                    if (image != null) {
                      ref.read(pickedProfileImagePathStateProvider.notifier).state = image.path; // Update the picked profile image path
                    }
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 21.sp,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
