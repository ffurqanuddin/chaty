import 'package:chaty/apis/firestore_api.dart';
import 'package:chaty/feature/customization/ui/customization_page.dart';
import 'package:chaty/feature/home/widgets/chat_user_card.dart';
import 'package:chaty/feature/home/widgets/home_screen_app_bar.dart';
import 'package:chaty/middleware/auth_middleware.dart';
import 'package:chaty/middleware/firestore_middleware.dart';
import 'package:chaty/models/chat_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../temp_data.dart';
import '../../get_blue_tick/ui/get_blue_tick.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      ///---------AppBar----------///
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text(
      //     "Chaty",
      //     style: TextStyle(
      //         color: Colors.white,
      //         letterSpacing: 1.3,
      //         fontWeight: FontWeight.w600),
      //   ),
      //   actions: [
      //     IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      //
      //     ///PopMenuButton
      //     PopupMenuButton(
      //       itemBuilder: (context) {
      //         return ref.watch(getCurrentUsersDataStreamProvider).when(
      //
      //             ///If Data
      //             data: (data) {
      //               final String username = data["name"];
      //               final String userImage = data["image"];
      //               final bool userVerified = data["blue_tick"];
      //
      //               return <PopupMenuEntry<dynamic>>[
      //                 PopupMenuItem(
      //                   child: ListTile(
      //                     contentPadding: EdgeInsets.zero,
      //                     tileColor: Colors.transparent,
      //
      //                     ///Username
      //                     title: Text(
      //                       username,
      //                       style: const TextStyle(fontWeight: FontWeight.w500),
      //                     ),
      //
      //                     ///Profile Image
      //                     leading: CircleAvatar(
      //                       child: ExtendedImage.network(
      //                         userImage,
      //                         cache: true,
      //                         border:
      //                             Border.all(color: Colors.black, width: 1.0),
      //                         shape: BoxShape.circle,
      //                         borderRadius:
      //                             const BorderRadius.all(Radius.circular(30.0)),
      //                       ),
      //                     ),
      //
      //                     ///Logout
      //                     trailing: IconButton(
      //                         onPressed: () {
      //                           AuthMiddleWare().logOutNow(context);
      //                         },
      //                         icon: const Icon(Icons.logout)),
      //
      //                     ///Goto Profile Screen
      //                     onTap: () {},
      //                   ),
      //                 ),
      //
      //                 ///Customization
      //                 if (userVerified)
      //                   PopupMenuItem(
      //                       child: ListTile(
      //                     tileColor: Colors.transparent,
      //                     title: const Text(
      //                       "Customization",
      //                       style: TextStyle(fontWeight: FontWeight.w500),
      //                     ),
      //                     leading: const Icon(Icons.settings),
      //                     onTap: () {
      //                       Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) =>
      //                                 CustomizationPage(),
      //                           ));
      //                     },
      //                   )),
      //
      //                 ///Get Verification Tick Now
      //                if(userVerified == false) PopupMenuItem(
      //                     child: ListTile(
      //                   tileColor: Colors.transparent,
      //                   title: const Text(
      //                     "Get Blue Tick",
      //                     style: TextStyle(fontWeight: FontWeight.w500),
      //                   ),
      //                   leading: const Icon(
      //                     Icons.verified_outlined,
      //                     color: Colors.blueAccent,
      //                   ),
      //                   onTap: () {
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                           builder: (context) => const GetBlueTickPage(),
      //                         ));
      //                   },
      //                 )),
      //               ];
      //             },
      //
      //             ///If Error
      //             error: (error, stackTrace) => <PopupMenuEntry<dynamic>>[
      //                   const PopupMenuItem(
      //                       child: ListTile(
      //                     leading: Icon(Icons.person),
      //                     title: Text("Something Went Wrong"),
      //                     trailing: CircularProgressIndicator(),
      //                   )),
      //                   const PopupMenuItem(
      //                       child: ListTile(
      //                     leading: Icon(Icons.settings),
      //                     title: Text("Something went wrong"),
      //                     trailing: CircularProgressIndicator(),
      //                   )),
      //                 ],
      //
      //             ///If Loading
      //             loading: () {
      //               return <PopupMenuEntry<dynamic>>[
      //                 const PopupMenuItem(
      //                     child: ListTile(
      //                   leading: Icon(Icons.person),
      //                   title: Text("Loading..."),
      //                 )),
      //               ];
      //             });
      //       },
      //     ),
      //   ],
      // ),

      appBar: PreferredSize(preferredSize: Size(double.infinity, 7.h), child: HomeAppBar()),
      ///------Body---------///
      body: ref.watch(getAllUsersDataStreamProvider).when(
            ///Data
            data: (data) {
              final List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                  data.docs;

              final List list =
                  myData.map((e) => ChatUserModel.fromJson(e.data())).toList();

              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => ChatUserCard(
                    user: list[index],
                  ),
                );
              } else {
                return const Center(
                  child: Text("No Connections found!"),
                );
              }
            },

            ///Error
            error: (error, stackTrace) => Center(
              child: Center(child: Text("Error : $error")),
            ),

            ///Loading
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}

///Providers
final getAllUsersDataStreamProvider =
    StreamProvider((ref) => FirestoreMiddleWare().getAllUserData());

final getCurrentUsersDataStreamProvider =
    StreamProvider((ref) => FirestoreMiddleWare().getCurrentUserData());


