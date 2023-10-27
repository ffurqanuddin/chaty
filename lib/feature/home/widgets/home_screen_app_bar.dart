import 'package:chaty/feature/profile/ui/profile_page.dart';
import 'package:chaty/middleware/firestore_middleware.dart';
import 'package:chaty/models/chat_user_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../middleware/auth_middleware.dart';
import '../../customization/ui/customization_page.dart';
import '../../get_blue_tick/ui/get_blue_tick.dart';
import '../ui/home_page.dart';

class HomeAppBar extends ConsumerStatefulWidget {
  HomeAppBar({
    super.key,
    required this.searchingList,
  });

  List<ChatUserModel> searchingList;

  @override
  ConsumerState<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends ConsumerState<HomeAppBar> {
  @override
  Widget build(
    BuildContext context,
  ) {
    Icon searchIcon = ref.watch(searchButtonIconStateProvider);
    bool searching = ref.watch(searchingProvider);
    return AppBar(
      automaticallyImplyLeading: false,

      ///---------App Logo & Search Field---------///
      title: searching
          ? TextField(
              maxLines: 1,
              onChanged: (value) {
                // widget.searchingList.clear();
                print("############\n(1)   $value");
                for (var i in widget.searchingList) {
                  if (i.name.toLowerCase().contains(value.toLowerCase()) ||
                      i.email.contains(value.toLowerCase())) {
                    widget.searchingList.add(i);
                    print("############\nI value =    $i");
                  }
                  setState(() {});

                }

              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: TextStyle(fontSize: 17.5.sp),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search by name, email",
              ),
            )
          : const Text(
              "Chaty",
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
              ref.read(searchingProvider.notifier).state = true;
              ref.read(searchButtonIconStateProvider.notifier).state =
                  const Icon(CupertinoIcons.clear);
            } else {
              ///----If Searching false------///
              ref.read(searchingProvider.notifier).state = false;
              ref.read(searchButtonIconStateProvider.notifier).state =
                  const Icon(CupertinoIcons.search);
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
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(userImage),
                            child: ExtendedImage.network(
                              userImage,
                              cache: true,
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              shape: BoxShape.circle,
                              fit: BoxFit.cover,
                            ),
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

///---Search Button Icon-----///
final searchButtonIconStateProvider = StateProvider<Icon>(
  (ref) => const Icon(Icons.search),
);

final searchingProvider = StateProvider<bool>((ref) => false);
