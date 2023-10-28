import 'package:chaty/feature/profile/ui/profile_page.dart'; // Import the profile page
import 'package:extended_image/extended_image.dart'; // Import an extended image widget
import 'package:flutter/cupertino.dart'; // Import Cupertino package for iOS-style widgets
import 'package:flutter/material.dart'; // Import Flutter's material library for UI components
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Flutter Riverpod for state management
import 'package:responsive_sizer/responsive_sizer.dart'; // Import responsive sizing for different screens

import '../../../middleware/auth_middleware.dart'; // Import middleware for authentication
import '../../../middleware/firestore_middleware.dart'; // Import middleware for Firestore interactions
import '../../customization/ui/customization_page.dart'; // Import customization page
import '../../get_blue_tick/ui/get_blue_tick.dart'; // Import a page for getting a blue verification tick

class HomeAppBar extends ConsumerStatefulWidget {
  HomeAppBar({
    super.key, // An optional key for identifying the widget
    required this.searchingList, // List for searching (probably user data)
    required this.searchController, // Controller for the search input field
  });

  List searchingList; // List for searching
  TextEditingController
      searchController; // Controller for the search input field

  @override
  ConsumerState<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    Icon searchIcon =
        ref.watch(searchButtonIconStateProvider); // Get the search button icon
    bool searching =
        ref.watch(searchingProvider); // Check if the app is in searching mode

    return AppBar(
      automaticallyImplyLeading: false, // Hide the leading back button

      ///---------App Logo & Search Field---------///
      title: searching
          ? TextField(
              maxLines: 1,
              controller: widget.searchController,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: TextStyle(fontSize: 17.5.sp),
              // Style for the search text field
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search by name, email",
              ),
            )
          : const Text(
              "Chaty", // Display "Chaty" when not in search mode
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w600),
            ),

      ///!!!!!!!!!!Actions Buttons!!!!!!!!!!!//////////
      actions: [
        ///------Search Button-------/////////
        IconButton(
          onPressed: () {
            if (searching == false) {
              ///---If Searching-------///
              ref.read(searchingProvider.notifier).state =
                  true; // Enable searching mode
              ref.read(searchButtonIconStateProvider.notifier).state =
                  const Icon(CupertinoIcons.clear); // Change the icon to clear
            } else {
              ///----If Searching false------///
              ref.read(searchingProvider.notifier).state =
                  false; // Disable searching mode
              ref.read(searchButtonIconStateProvider.notifier).state =
                  const Icon(
                      CupertinoIcons.search); // Change the icon to search
            }
          },
          icon: searchIcon,
        ),

        ///----------------------------------------////////

        ///--------Ver Menu Button---------////(Show it when searching false)
        if (searching == false)
          ref.watch(getCurrentUsersDataStreamProvider).when(
                ///############OnData###############///
                data: (data) {
                  final String username = data["name"];
                  final String userImage = data["image"];
                  final bool userVerified = data["blue_tick"];
                  return PopupMenuButton(
                    itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
                      ///------First Tile *Profile Image, Profile Name, Logout Button* ------///
                      PopupMenuItem(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          tileColor: Colors.transparent,

                          ///Username
                          title: Text(
                            username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          ///Profile Image
                          leading: CircleAvatar(
                            radius: 9.w,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: ExtendedImage.network(
                                height: 9.w,
                                width: 9.w,
                                fit: BoxFit.cover,
                                userImage,
                              ),
                            ),
                          ),

                          ///Logout
                          trailing: IconButton(
                            onPressed: () {
                              AuthMiddleWare()
                                  .logOutNow(context); // Log out the user
                            },
                            icon:
                                const Icon(Icons.logout), // Show a logout icon
                          ),

                          ///Goto Profile Screen
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePage(), // Navigate to the user's profile page
                                ));
                          },
                        ),
                      ),

                      ///------Second Tile *Customization* ------///
                      if (userVerified)
                        PopupMenuItem(
                            child: ListTile(
                          tileColor: Colors.transparent,
                          title: const Text(
                            "Customization",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          leading: const Icon(Icons.settings),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomizationPage(), // Navigate to the customization page
                                ));
                          },
                        )),

                      ///------3rd Tile *Unlock More features* ------///
                      if (userVerified == false)
                        PopupMenuItem(
                            child: ListTile(
                          tileColor: Colors.transparent,
                          title: const Text(
                            "Unlock More Features",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          leading: const Icon(
                            Icons.verified_outlined,
                            color: Colors.blueAccent,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GetBlueTickPage(), // Navigate to the blue tick page
                                ));
                          },
                        )),
                    ],
                  );
                },

                ///############OnError###############///
                error: (error, stackTrace) => const Icon(Icons.error_outline),

                ///############OnLoading###############///
                loading: () => IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.transparent,
                    )),
              ),
      ],
    );
  }
}

///---Search Button Icon-----///
final searchButtonIconStateProvider = StateProvider<Icon>(
  (ref) => const Icon(
      Icons.search), // Set the initial search button icon to 'search'
);

final searchingProvider =
    StateProvider<bool>((ref) => false); // Initialize searching mode as false

final getCurrentUsersDataStreamProvider = StreamProvider((ref) =>
    FirestoreMiddleWare()
        .getCurrentUserData()); // Provide user data stream from Firestore
