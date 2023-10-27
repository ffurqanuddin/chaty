import 'package:chaty/feature/home/widgets/chat_user_card.dart';
import 'package:chaty/feature/home/widgets/home_screen_app_bar.dart';
import 'package:chaty/middleware/firestore_middleware.dart';
import 'package:chaty/models/chat_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../apis/user_online_status_handler.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<ChatUserModel> searchingList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///Update User Online Status and last active time and store it firestore
    UserOnlineStatusHandler().initializeUserOnlineStatus();

    ///------Search User--------///
    searchController.addListener(() async {
      // Update the searchingList state variable with the list of users that match the search query.
      if (searchController.text.isNotEmpty) {
        final AsyncValue<List<ChatUserModel>> asyncData = await ref
            .watch(getAllUsersDataStreamProvider)
            .whenData((data) => data.docs
                .map((e) => ChatUserModel.fromJson(e.data()))
                .toList()
                .where((user) =>
                    (user.name)
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()) ||
                    (user.email)
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()))
                .toList());

        if (asyncData.hasValue) {
          searchingList = asyncData.asData!.value;
        } else {
          searchingList.clear();
        }
      } else {
        searchingList.clear();
      }

      setState(() {});
    });

    ///-----------------------------------------------------------//////
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      ///---------AppBar----------///
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 7.h),
          child: HomeAppBar(
            searchingList: searchingList,
            searchController: searchController,
          )),

      ///------Body---------///
      body: ref.watch(getAllUsersDataStreamProvider).when(
            ///Data
            data: (data) {
              final List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                  data.docs;

              final List<ChatUserModel> list =
                  myData.map((e) => ChatUserModel.fromJson(e.data())).toList();
              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: ref.watch(searchingProvider)
                      ? searchingList.length
                      : list.length,
                  itemBuilder: (context, index) => ChatUserCard(
                    user: ref.watch(searchingProvider)
                        ? searchingList[index]
                        : list[index],
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

///----------------------------------***Providers***------------------------------------------///
final getAllUsersDataStreamProvider =
    StreamProvider((ref) => FirestoreMiddleWare().getAllUserData());

final getCurrentUsersDataStreamProvider =
    StreamProvider((ref) => FirestoreMiddleWare().getCurrentUserData());
