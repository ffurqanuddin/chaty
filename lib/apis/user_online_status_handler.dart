import 'dart:async';

import 'package:chaty/apis/firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'auth_api.dart';

class UserOnlineStatusHandler {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirestoreAPI firestoreApi = FirestoreAPI();

  initializeUserOnlineStatus() {
    //FOr setting user status to active
    _updateActiveStatusInFirestore(true);

    ///for updating user active status according to lifecycle events
    ///resume -- active or online
    ///pause -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (kDebugMode) {
        print("${Future.value()}");
      }

      if (AuthAPI().currentUser != null) {
        if (message.toString().contains('resume'))
          _updateActiveStatusInFirestore(true);
        if (message.toString().contains('pause'))
          _updateActiveStatusInFirestore(false);
      }

      return Future.value();
    });
  }

  ///-------------------------////////////////
  /// Update the user's online status and last active time in firestore
  Future<void> _updateActiveStatusInFirestore(bool isOnline) async {
    firestore
        .collection(firestoreApi.userCollection)
        .doc(firestoreApi.currentUserID)
        .update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
