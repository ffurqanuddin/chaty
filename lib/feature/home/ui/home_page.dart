import 'package:chaty/feature/home/widgets/chat_user_card.dart';
import 'package:chaty/feature/home/widgets/home_screen_app_bar.dart';
import 'package:chaty/middleware/firestore_middleware.dart';
import 'package:chaty/models/chat_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      ///---------AppBar----------///
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


