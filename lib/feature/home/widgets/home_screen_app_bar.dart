import 'package:chaty/feature/profile/ui/profile_page.dart';
import 'package:chaty/middleware/firestore_middleware.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../middleware/auth_middleware.dart';
import '../../customization/ui/customization_page.dart';
import '../../get_blue_tick/ui/get_blue_tick.dart';
import '../ui/home_page.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        "Chaty",
        style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.3,
            fontWeight: FontWeight.w600),
      ),

      ///!!!!!!!!!!Actions Buttons!!!!!!!!!!!//////////
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
                          style:  const TextStyle(fontWeight: FontWeight.w500, ),
                        ),

                        ///Profile Image
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(userImage),
                          // child: ExtendedImage.network(
                          //   userImage,
                          //   cache: true,
                          //   border: Border.all(color: Colors.black, width: 1.0),
                          //   shape: BoxShape.circle,
                          //   fit: BoxFit.cover,
                          // ),
                        ),

                        ///Logout
                        trailing: IconButton(
                            onPressed: () {
                              AuthMiddleWare().logOutNow(context);
                            },
                            icon: const Icon(Icons.logout)),

                        ///Goto Profile Screen
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
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
                                builder: (context) => CustomizationPage(),
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
                                builder: (context) => const GetBlueTickPage(),
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
